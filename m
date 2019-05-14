Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8501CACC
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2019 16:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfENOsU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 10:48:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52450 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfENOsT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 10:48:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id y3so3206464wmm.2
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 07:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oVzNv9Cda4AG48ayrkoKl5rIu1/NIqCv8NqNC2WTHNk=;
        b=PWGMigxrpID6s8IULkbH99Y1lhvCduvvj46ce+Jn7M72fT9TeIXEZYECmVOQCUQNHr
         FApeJ4e7A9fYy9hxGe5qnCUNcXvgdNuVkhfOD5K1xtfRWbarEA7+dfHVLkK7x7+g3xiK
         Re4w+Z+2GFCXOd0H6gAQJMx6YjB9hvvcVK8f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oVzNv9Cda4AG48ayrkoKl5rIu1/NIqCv8NqNC2WTHNk=;
        b=JXLW/sBGN89jdT0B0VNqsSyf7xrNHPxxb2j9HBNjV+AK7NrY9l8fFRJ5rUo8kb93UH
         F2Txvlmz/towjvDkrEKA6t4Ln+1Y1CUuqblswhbJe6OaMLXzsxhBFju0AXbHTWyueJT8
         A9t59WHu0ihkCB6us3Q7Qbf1dc5ftZvTpQgv6n9Dd9enMc/bkdHn2ddMDsIaBAqgOvLC
         CmQ2lhlYrtGep6ogNiwvygwVRRUMQKH2OX5Ma9qdR4SKVN0QMxqr2YTdRRSoqlaghnfo
         /orkz1xoulG6XxdfWQg2OkLrn9wpGgCcE+jJW0Ovfrhv+i/FlO4nmYHZels4/mXYQfSf
         58Tg==
X-Gm-Message-State: APjAAAXE8BrQzvt3EMl7v00cjelBF/tjYctYeA2ih6pQJ2YdxYJD+cu4
        9WYIH+AhgX3JNa8dpa4gTSdk1g==
X-Google-Smtp-Source: APXvYqxYk6Oc5UfGGWqyARsIZbZicHGDxdaBpkaV0YzlrdD1K6Gucx02gXt4F3GaCGNm3U6vsVvpfQ==
X-Received: by 2002:a1c:3c2:: with SMTP id 185mr2275481wmd.91.1557845297691;
        Tue, 14 May 2019 07:48:17 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id p6sm12048114wrs.6.2019.05.14.07.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 07:48:17 -0700 (PDT)
Date:   Tue, 14 May 2019 16:48:06 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/5] IB/hfi1: Fix improper uses of smp_mb__before_atomic()
Message-ID: <20190514144806.GA14962@andrea>
References: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1556568902-12464-6-git-send-email-andrea.parri@amarulasolutions.com>
 <14063C7AD467DE4B82DEDB5C278E8663BE6AADCE@FMSMSX108.amr.corp.intel.com>
 <20190429231657.GA2733@andrea>
 <20190509211221.GA4966@andrea>
 <0a78eded-6c08-8d32-ec31-d62d6feb2118@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a78eded-6c08-8d32-ec31-d62d6feb2118@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 14, 2019 at 08:32:52AM -0400, Dennis Dalessandro wrote:
> On 5/9/2019 5:12 PM, Andrea Parri wrote:
> >On Tue, Apr 30, 2019 at 01:16:57AM +0200, Andrea Parri wrote:
> >>Hi Mike,
> >>
> >>>>This barrier only applies to the read-modify-write operations; in
> >>>>particular, it does not apply to the atomic_read() primitive.
> >>>>
> >>>>Replace the barrier with an smp_mb().
> >>>
> >>>This is one of a couple of barrier issues that we are currently looking into.
> >>>
> >>>See:
> >>>
> >>>[PATCH for-next 6/9] IB/rdmavt: Add new completion inline
> >>>
> >>>We will take a look at this one as well.
> >>
> >>Thank you for the reference and for looking into this,
> >
> >So, I'm planning to just drop this patch; or can I do something to help?
> >
> >Please let me know.
> 
> Mike was looking into this, and I've got a handful of patches from him to
> review. He's unavailable for a while but if it's not included in the patches
> I've got we'll get something out shortly. So yes I think we can hold off on
> this patch for now. Thanks.

Thank you for the confirmation, Dennis.  I'll hold off on this one.

  Andrea
