Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9312C2A998B
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Nov 2020 17:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgKFQhw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 11:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFQhv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Nov 2020 11:37:51 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96372C0613CF
        for <linux-rdma@vger.kernel.org>; Fri,  6 Nov 2020 08:37:51 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 140so1613611qko.2
        for <linux-rdma@vger.kernel.org>; Fri, 06 Nov 2020 08:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1CDcjXV5zOC1KUdsTI194YdaJaRejWBY6TZu6uM074k=;
        b=gyduOqwy5X0evuo3oVFkBiKriwp62AWxOh3YpIfyJE1oulfWzoEJSHw6iA4Dsutosr
         dLSeDHxmA2vDN0YBl3t7e4D4vfaCmR2xeTTR4FBSnx2NmBFos134Y2LmvqSPPqaWJ7xN
         C0S+4T2qy3oJcQWwiSMXo5YB8pBYx9DRCtv0WtF+DNFHZDTl9ORnEx7R8Di5IW1oN1ww
         28WeZTWjjLfKIZLy6Kxjt0yi2sgfDlu/tfpqO4O3Ksq3vByEGa+IFjvsfV/0aA7WFjiw
         Cxbw7OnFud4Oxp/rOJ8OHfT/HHhV5PfNCqUeIbnoO3+yZ2PbTaZ2/VrxNS2CouX6wiPR
         10RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1CDcjXV5zOC1KUdsTI194YdaJaRejWBY6TZu6uM074k=;
        b=e/bqdyhz2M7XAWCz0TSEKP6jOXLqVblyIZ4ZjXu5WrF7gcmP/SjvZimUh5W/ZE/ekl
         eKqPngfi5cTiIgGYsOsjgtKM6mIGdKb6Zim1wed9thdXLh2dRZUSjB/dVCt7OT2szoDb
         0qTXojfD/3RuBnkwAmvAo8DeR9jOSpQoTbCrZqWEhPA0krzJ1VdhLNzEt7CP3xwKUw+R
         2LZtHZDIkup8c+cZkJjkEfAAVLBhUGadfh0KN+oT+KX/kJgIdfxBo+TT55bkx3mfrTN3
         6Oodm3c1WuDmr/Iwt+7Nbs4K6nPbDnTzrJ2KcGAdduqTImxcUAVniRxGIzTqsLCRuNB+
         dYdQ==
X-Gm-Message-State: AOAM5330JcqKO+KEPSY0mCcn+NZ/zCYAF/dYoCheDPAGrmp6qU/Oa4cu
        d/lbNr8MyRiAIPjRTywiWRUCHA==
X-Google-Smtp-Source: ABdhPJzqt1hKj4/mfI1i1srDPyEST9aWdEgA9pLhUjft8bX9En9FCI9k50pLg3WSs+m8MZmaRhrE2w==
X-Received: by 2002:ae9:f44a:: with SMTP id z10mr2354548qkl.247.1604680670829;
        Fri, 06 Nov 2020 08:37:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id s23sm830036qks.94.2020.11.06.08.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 08:37:49 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kb4kH-000xeI-Au; Fri, 06 Nov 2020 12:37:49 -0400
Date:   Fri, 6 Nov 2020 12:37:49 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Subject: Re: [PATCH v8 3/5] RDMA/uverbs: Add uverbs command for dma-buf based
 MR registration
Message-ID: <20201106163749.GQ36674@ziepe.ca>
References: <1604616489-69267-1-git-send-email-jianxin.xiong@intel.com>
 <1604616489-69267-4-git-send-email-jianxin.xiong@intel.com>
 <20201106001303.GL36674@ziepe.ca>
 <MW3PR11MB4555B5ABCE53B195B5EF0AE7E5ED0@MW3PR11MB4555.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB4555B5ABCE53B195B5EF0AE7E5ED0@MW3PR11MB4555.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 06, 2020 at 04:20:34PM +0000, Xiong, Jianxin wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Thursday, November 05, 2020 4:13 PM
> > To: Xiong, Jianxin <jianxin.xiong@intel.com>
> > Cc: linux-rdma@vger.kernel.org; dri-devel@lists.freedesktop.org; Doug Ledford <dledford@redhat.com>; Leon Romanovsky
> > <leon@kernel.org>; Sumit Semwal <sumit.semwal@linaro.org>; Christian Koenig <christian.koenig@amd.com>; Vetter, Daniel
> > <daniel.vetter@intel.com>
> > Subject: Re: [PATCH v8 3/5] RDMA/uverbs: Add uverbs command for dma-buf based MR registration
> > 
> > On Thu, Nov 05, 2020 at 02:48:07PM -0800, Jianxin Xiong wrote:
> > 
> > > +	ret = ib_check_mr_access(access_flags);
> > > +	if (ret)
> > > +		return ret;
> > 
> > This should also reject unsupportable flags like ACCESS_ON_DEMAND and HUGETLB
> 
> Will do.

Just change IB_ACCESS_SUPPORTED to the list of allowed flags in this
context


> > > +	mr->device  = pd->device;
> > > +	mr->pd      = pd;
> > > +	mr->type    = IB_MR_TYPE_USER;
> > > +	mr->uobject = uobj;
> > > +	atomic_inc(&pd->usecnt);
> > 
> > Fix intending when copying code please
> 
> It could be due to a mix of tab and space. They look aligned in the source file. Will fix.

The interior spaces before the = should not be there, we don't align ='s

Jason
