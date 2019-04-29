Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8089EED3E
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 01:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfD2XRH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Apr 2019 19:17:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39883 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfD2XRH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Apr 2019 19:17:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so1434861wmk.4
        for <linux-rdma@vger.kernel.org>; Mon, 29 Apr 2019 16:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JYx/PpUETf62rnmWyBuVYJne6sL4Sppeoe68UBu+C48=;
        b=ofZYrEPWt3bOdtLGI4gwtxKCfg1DysFTX6WH2zp9NWFz4iSq/7S8g6I5rFTdm5lBTp
         olAIovsqhJvbvwceg95f+xrWfROSL61Q2fMufVhSmYbZEJbpAXHkWNXebH9MmbE9yXqK
         FARDvfWDj9MT//C1OTJ/dGMi5pWW61L6WcYx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JYx/PpUETf62rnmWyBuVYJne6sL4Sppeoe68UBu+C48=;
        b=NBKXBRMQd9IpRrpb9olKZtPsoZmeTae5+8Vn+a2tHdk7ONeuEzSWgZ1A6G4dGrvxpO
         sI3yVqUL1W/1skI5+3nM0CSp6Z81x3JlFwFQhF6l/FD3jx4CdlREONm7U4pUmeLy9KHU
         YSuU7FBP3uX57lv6LV6dTIgMInq7KradjxjFdPz24DaN5o1Omb7WLlKvJ6lWZzz+S0aD
         HZOQyRx41CQfLEhleG+Mti3mB7s1BElxUWhZMr8IFn/BGo8AWJGtJTopZHO1/Ci3LxFv
         SsuvPMBB+dvl3orPo8QByadKdK71v3IUc7CbBpyWoqN4vVO6HRfnCsWlKGDTCviq9ioV
         jUHQ==
X-Gm-Message-State: APjAAAVGxPhLMB7lJulJSezAEemYFxc8qoF2aeO4XXUPx6de5YV1HwNe
        CKYHtWUfvsAmeYE+mIopxX1sZQ==
X-Google-Smtp-Source: APXvYqwWNE+lo2Lmp4qExHW5Coy5MDuwao1zLqsY/frUnjQhkdUMLFonDKJe9juMWfTUs9n51gbhVQ==
X-Received: by 2002:a1c:3cc2:: with SMTP id j185mr982553wma.26.1556579825704;
        Mon, 29 Apr 2019 16:17:05 -0700 (PDT)
Received: from andrea (ip-93-97.sn2.clouditalia.com. [83.211.93.97])
        by smtp.gmail.com with ESMTPSA id z11sm848336wmf.12.2019.04.29.16.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 16:17:04 -0700 (PDT)
Date:   Tue, 30 Apr 2019 01:16:57 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 5/5] IB/hfi1: Fix improper uses of smp_mb__before_atomic()
Message-ID: <20190429231657.GA2733@andrea>
References: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1556568902-12464-6-git-send-email-andrea.parri@amarulasolutions.com>
 <14063C7AD467DE4B82DEDB5C278E8663BE6AADCE@FMSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14063C7AD467DE4B82DEDB5C278E8663BE6AADCE@FMSMSX108.amr.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Mike,

> >This barrier only applies to the read-modify-write operations; in
> >particular, it does not apply to the atomic_read() primitive.
> >
> >Replace the barrier with an smp_mb().
> 
> This is one of a couple of barrier issues that we are currently looking into.
> 
> See:
> 
> [PATCH for-next 6/9] IB/rdmavt: Add new completion inline
> 
> We will take a look at this one as well.

Thank you for the reference and for looking into this,

  Andrea
