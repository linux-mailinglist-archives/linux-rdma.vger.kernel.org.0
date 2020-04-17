Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C9A1ADD65
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2020 14:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgDQMfi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Apr 2020 08:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727877AbgDQMfh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Apr 2020 08:35:37 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC055C061A0C
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2020 05:35:37 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 20so2105610qkl.10
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2020 05:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TqCdGc0Me+uJBSVA6SEi2XVYoiYD5p4Z/QOYuhMDTKM=;
        b=SyStNrA6i39cziPIwvY5z1dZrHkb91ny44DrRZ7FD61BcOpMuX1J0/45c5VVZU7hT1
         qv0om7a61wh8PxUsodihheG2EYaXiaFDLMCA56n9efq9Z9WvVPLgbPrWc6L6ArJz9i0H
         +VwhXQujI5AedVqiMJ/FT1hdM9Jn2Yo8Iljg6K5zRvMsZKbNwy1DVe/JXSQ4aEK01ovH
         o4J1CvqpwMf+UsSQWCTDt1ShTiz4NyqMc0VX+7QDf3kA3oQi3RRMEheZlsqb0+J5ZSyE
         7qQZzFFWl5gzScS26NsVT5Suj92vY8ZHzSrTHGH2R27OU3PNv729x5ADj864q86SjAHL
         +4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TqCdGc0Me+uJBSVA6SEi2XVYoiYD5p4Z/QOYuhMDTKM=;
        b=bsnycTTQucVKC4+FIgiYLNt/5Qv45AdgNXiTgTNMpf2K2OS5KbbwZYEkfGQDZ9Hyji
         PylDwrJQTN2MuJU+UwgGywL5PHUQ2d+hZX/BStx/Qk1wx5tgVFerbKMYu53GKfjDGRKh
         mSt50lkSEKxNhOipcalERO7UK2/ndhMxpm6qNKrjeoINWCgUSdBk0pDVumsmsMiQzTz2
         M6ynias6cQWK8rHjkPpSJh83dSArUPWyP4U1w/7+Le7q56wrvyx+DnUXYmo3zVf2cJKF
         jIjzAbYTuYdPagzRQzgAoEUPlNqKPhMn1bUz6L1+Tp1STqW8HhIztepaF1CxBgfJpB4x
         y5Kw==
X-Gm-Message-State: AGi0PuaOEaa9Ht0MFD0Nlm6eoO8W6vqsnxnH3A9jZUU5RX2IOH+8wYiM
        istd0WPTfI0RbizE/zP/xj5ozA==
X-Google-Smtp-Source: APiQypKNRrZUZQPqnaJD6tyLJr0qRwdUN9BMh/yNG3rSgcyBJyKGwrYV9XAgbt0iBpr38rCkJ0hyqQ==
X-Received: by 2002:a37:6697:: with SMTP id a145mr2981696qkc.479.1587126936917;
        Fri, 17 Apr 2020 05:35:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x24sm17994705qth.80.2020.04.17.05.35.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Apr 2020 05:35:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jPQDX-00071A-WD; Fri, 17 Apr 2020 09:35:36 -0300
Date:   Fri, 17 Apr 2020 09:35:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [RFC PATCH 2/3] RDMA/uverbs: Add uverbs commands for fd-based MR
 registration
Message-ID: <20200417123535.GC26002@ziepe.ca>
References: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
 <1587056973-101760-3-git-send-email-jianxin.xiong@intel.com>
 <20200416174748.GS5100@ziepe.ca>
 <MW3PR11MB45556D47A2D3767A4ECC32BFE5D80@MW3PR11MB4555.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB45556D47A2D3767A4ECC32BFE5D80@MW3PR11MB4555.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 16, 2020 at 06:32:01PM +0000, Xiong, Jianxin wrote:
> > >  	SET_DEVICE_OP(dev_ops, read_counters);
> > >  	SET_DEVICE_OP(dev_ops, reg_dm_mr);
> > >  	SET_DEVICE_OP(dev_ops, reg_user_mr);
> > > +	SET_DEVICE_OP(dev_ops, reg_user_mr_fd);
> > >  	SET_DEVICE_OP(dev_ops, req_ncomp_notif);
> > >  	SET_DEVICE_OP(dev_ops, req_notify_cq);
> > >  	SET_DEVICE_OP(dev_ops, rereg_user_mr);
> > > +	SET_DEVICE_OP(dev_ops, rereg_user_mr_fd);
> > 
> > I'm not so found of adding such a specific callback.. It seems better to have a generic reg_user_mr that accepts a ib_umem created by the
> > core code. Burying the umem_get in the drivers was probably a mistake.
> 
> I totally agree. But that would require major changes to the uverbs workflow.

I don't think it is that bad and would prefer it

Jason
