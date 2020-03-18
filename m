Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E8B18A932
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 00:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCRX2d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 19:28:33 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37607 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRX2d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 19:28:33 -0400
Received: by mail-qv1-f68.google.com with SMTP id n1so56839qvz.4
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 16:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mm3MksJ3BUo7zZdHMDp9yMRTpM8pOfN7QwrIIYT8tHc=;
        b=KIJ0Np7WfmPtoWIFKjTpwcXtbh/OOMwBxU7W+Ajua/9UGjcJNjehZJwDeZ9EX8O0wX
         3MDwTO4wKKP/0exx0CHNitnplnLRG49ruBN6MncDCE1aMKIlyrIFVG1dPP+Gaw132VlM
         Q05hGSoc1nF/qh/aEVNxNQZJrE9+mfTK96/QiVM6PpdMucHpmQ6w9G4gKzO17zgtKYoh
         VFc2E/KUcGVkH4+E3P7eQS9pw1s0V0JX+4CKtFM93uUuD0PxTqHPtqN5UIFAQwfK0YU3
         aAV0wBtDIv9+RZcXGLK6bzgpFUogLBtlN80kfoTkI4yX+w2hVrQs7F5IP5kUr4xkzvyw
         jC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mm3MksJ3BUo7zZdHMDp9yMRTpM8pOfN7QwrIIYT8tHc=;
        b=E090O1WdNsZ5z1gh0WTdfo8ZGM0iRKJ0MhO6HSC1C5wcHHKrGEZhHDD1nVyuR0wtUY
         n+BVKr0Vke8MLnKX3bJoMVUWZ/4u+SviGMPCQT79EK0/t/UtSHs+nMmsjbwsAxa7U0iE
         sdmNUQc4sVaKCOgQo2V+inCtMUlL/v3COrEInlzH6aFxcZWRz7GLgR90WmfzdFt9t4UQ
         9PxyocPE9rMnJW6f0r6lrEZVl3+OvI0uGwhA+iRf1HpXgEGUtS0PH7R5p1twAmC7vPBb
         sSnEuPFlgFTJrtzMpVXVcSclirkzAgjqVVrE1uFxCjEB1pyCjBq6//lCV2kuOxJX128F
         tZKQ==
X-Gm-Message-State: ANhLgQ0dyBpnO0vFjy8cZ90xCHi4iAezIsqVCEOjVM8Ir/TbBIRcvNTC
        5f2rdSv+73FddypjsvGSGGCSk3VwJVLngA==
X-Google-Smtp-Source: ADFU+vvf0ZVEKO1E2QvID6Dbah38JvI5prANO4qh9aIhJIS9pny8ESGbSnWOMp5frtaIGQvscbdm+w==
X-Received: by 2002:a0c:fde7:: with SMTP id m7mr385068qvu.53.1584574111811;
        Wed, 18 Mar 2020 16:28:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id b25sm365261qkk.28.2020.03.18.16.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 16:28:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jEi6w-0004r8-Rh; Wed, 18 Mar 2020 20:28:30 -0300
Date:   Wed, 18 Mar 2020 20:28:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/3] Clean up and improvements for 5.7
Message-ID: <20200318232830.GA18585@ziepe.ca>
References: <20200316210246.7753.40221.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316210246.7753.40221.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 16, 2020 at 05:04:47PM -0400, Dennis Dalessandro wrote:
> Here are some clean up/improvement patches. Mike got rid of dead code and Kaike
> took a stab at fixing the kobj and cdev complaints.  This serious should
> go before the AIP posting. I'll be posting a v2 of the AIP code soon, and I
> think I still owe a response on one issue. Coming up, but for now it's just
> these 3.
> 
> 
> Kaike Wan (2):
>       IB/hfi1: Remove kobj from hfi1_devdata
> 
> Mike Marciniszyn (1):
>       IB/rdmavt: Delete unused routine

I'm going to take these two to for-next

>       IB/hfi1: Use the ibdev in hfi1_devdata as the parent of cdev

This one is getting closer to the right idea but needs a lot more work

Thanks,
Jason
