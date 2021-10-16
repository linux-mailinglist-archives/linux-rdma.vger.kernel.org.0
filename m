Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA711430328
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Oct 2021 17:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbhJPPHj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 16 Oct 2021 11:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbhJPPHi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 16 Oct 2021 11:07:38 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FBBC061570
        for <linux-rdma@vger.kernel.org>; Sat, 16 Oct 2021 08:05:30 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id h20so6824967qko.13
        for <linux-rdma@vger.kernel.org>; Sat, 16 Oct 2021 08:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FMSUVK42h9kVn8JAi1haAUF7g3jblVN1qN3foaiI4Ho=;
        b=Q7Wdx2ZQsg+BmREsfycU7LZPpxV4Am6Xq602HGGcgSQluxyzUEeVf1FAQgTS7vILw3
         XnI/YpLFIZqusbUAOTKwWMg876KmtRjvy16b6ogxeREqMv9MA16FWbUckH/haGzLd4MD
         RuVtKKjsP4qnuTYfPj9TRQd7MlwokZrgbhk9SFcnF8ROKjkBHqTHp79z4G6aKAilots9
         DWI2KUAf8p8yROWtBAHYOIxAEZU5/fKuqT/5z3sZDf3QHdZMMYBmF5BG4kr/1D2+Csxo
         IaMILni3TLZuXtmkJKedB4zxGyyaRSEHl9AGEdMki87zWv6SfMH3VoaBg8erL+rjItY1
         sAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FMSUVK42h9kVn8JAi1haAUF7g3jblVN1qN3foaiI4Ho=;
        b=0+bXZuqsO+xhdaK834TqYGGrorXspQJnzAMnTrWJmrXJl/AvSXeRdlVw1hvd+Fsc1V
         V3CEsfUGVxZy+w8UGpnTpvaiqR48RiVbne2SXnZpHqwOTEdqIIliQhH05RRUhdweJGS0
         59EUKwgzsvvLbzR24pBvx7i1t1CKOs7doZnndzntHSd/JgNrogfP1/N6TXLY4KHHRVNZ
         zccErsc5on8rD5k6GZsKY+dElouDUSzAL4TZLAsLYq3nOu9oE6p5Yg2wTweQdTGv/QXp
         UHQ7JS/GFa+njr6Vr8BxjWxY1fLKSrZB7hCSAGXapcapymLD8BEr3Ax4RfpqeJdx5pOj
         hK8w==
X-Gm-Message-State: AOAM533opB2eDZFMY+ufryjxk00xq1unS0RuHmS6hoppBy7axSWJ0Ums
        1O9cQWBsx7Hpbwcoo4uAT/S3JH9WLT0=
X-Google-Smtp-Source: ABdhPJzhC9xvXjkXWILEJa5/zV27lFsEF03SazUnWYsRfbi4U1gdPObaC4rrADqnOYSnfGgIJ4b1sg==
X-Received: by 2002:a37:6c83:: with SMTP id h125mr14576960qkc.486.1634396729809;
        Sat, 16 Oct 2021 08:05:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id e4sm4512224qty.59.2021.10.16.08.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 08:05:29 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mblFY-00FhE2-9E; Sat, 16 Oct 2021 12:05:28 -0300
Date:   Sat, 16 Oct 2021 12:05:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Devale, Sindhu" <sindhu.devale@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>
Subject: Re: Question on PD validation
Message-ID: <20211016150528.GA3686969@ziepe.ca>
References: <SA2PR11MB495343C46850C730BA4203C1F3B59@SA2PR11MB4953.namprd11.prod.outlook.com>
 <20211012161001.GK2688930@ziepe.ca>
 <SA2PR11MB4953C4290A30F50305F7077EF3B99@SA2PR11MB4953.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA2PR11MB4953C4290A30F50305F7077EF3B99@SA2PR11MB4953.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 15, 2021 at 11:09:37PM +0000, Devale, Sindhu wrote:
> 
> 
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Tuesday, October 12, 2021 11:10 AM
> > To: Devale, Sindhu <sindhu.devale@intel.com>
> > Cc: linux-rdma@vger.kernel.org; Saleem, Shiraz <shiraz.saleem@intel.com>
> > Subject: Re: Question on PD validation
> > 
> > On Mon, Oct 11, 2021 at 11:05:02PM +0000, Devale, Sindhu wrote:
> > > Hi all,
> > >
> > > Currently, when an application creates a PD, the ib uverbs creates a PD
> > uobj resource and tracks it through the xarray which is looked up using an
> > uobj id/pd_handle.
> > >
> > > If a user application were to create a verb resource, example QP, with
> > some random ibv_pd object  [i.e. one not allocated by user process], whose
> > pd_handle happens to match the id of created PDs, the QP creation would
> > succeed though one would expect it to fail For example:
> > > During an alloc PD:
> > > irdma_ualloc_pd, 122], pd_id: 44, ibv_pd: 0x8887c0, pd_handle: 0
> > >
> > > During create QP:
> > > [irdma_ucreate_qp, 1480], ibv_pd: 0x8889f0, pd_handle: 0
> > >
> > >
> > > Clearly, the ibv_pd that the application wants the QP to be associated
> > > with is not the same as the ibv_pd created during the allocation of
> > > PD. Yet, the creation of the QP is successful as the pd handle of 0
> > > matches.
> > 
> > Most likely handle 0 is a PD, generally all uobj's require a PD to be created so
> > PD is usually the thing in slot 0.
> > 
> > The validation that the index type matches is done here:
> > 
> > 	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_PD_HANDLE,
> > 			UVERBS_OBJECT_PD,
> > 			UVERBS_ACCESS_READ,
> > 			UA_OPTIONAL),
> > Which is passed into this:
> > 
> > static int uverbs_process_attr(struct bundle_priv *pbundle,
> > 			       const struct uverbs_api_attr *attr_uapi,
> > 			       struct ib_uverbs_attr *uattr, u32 attr_bkey) {
> > 	case UVERBS_ATTR_TYPE_IDR:
> > 		o_attr->uobject = uverbs_get_uobject_from_file(
> > 			spec->u.obj.obj_type, spec->u.obj.access,
> > 			uattr->data_s64, &pbundle->bundle);
> > 
> > Which eventually goes down into this check:
> > 
> > 
> > struct ib_uobject *rdma_lookup_get_uobject(const struct uverbs_api_object
> > *obj,
> > 					   struct ib_uverbs_file *ufile, s64 id,
> > 					   enum rdma_lookup_mode mode,
> > 					   struct uverbs_attr_bundle *attrs) {
> > 
> > 		if (uobj->uapi_object != obj) {
> > 			ret = -EINVAL;
> > 			goto free;
> > 		}
> > 
> > Which check the uobj the user provided is the same type as the schema
> > requires.
> > 
> > The legacy path is similar, we start here:
> > 
> > 		pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd-
> > >pd_handle,
> > 				       attrs);
> > 
> > Which also calls rdma_lookup_get_uobject() and does the same check.
> > 
> > Jason
> 
> Hi Jason,
> 
> Thank you for responding. 
> 
> >struct ib_uobject *rdma_lookup_get_uobject(const struct uverbs_api_object *obj,
> 					   struct ib_uverbs_file *ufile, s64 id,
> 					   enum rdma_lookup_mode mode,
> 					   struct uverbs_attr_bundle *attrs) {
> 					
> The lookup for a uobj in the above function happens based on the uobj id.
> 
> When an application creates a PD, ib_uverbs_alloc_pd() creates a uobj for the corresponding and assigns id of the uobj to the response pd_handle:
> 
> resp.pd_handle = uobj->id;
> 
> For example, I am creating two PDs:
> 
> ibv_pd: 0x21a4d00, pd_handle: 0
> [ib_uverbs_alloc_pd, 458], allocated: 00000000d8facf77, uobject: 000000001584c2c2, pd_handle: 0
> 
> ibv_pd: 0x21b7a70, pd_handle: 1
> [ib_uverbs_alloc_pd, 458], allocated: 0000000048001c84, uobject: 00000000a9cacf67, pd_handle: 1
> 
> What's going into create_qp:
> 
> ibv_pd: 0x21b3c90, pd_handle: 0
> [create_qp, 1392], cmd->pd_handle: 0
> [rdma_lookup_get_uobject, 381], id to lookup: 0
> [rdma_lookup_get_uobject, 396], uobj retrieved: 000000001584c2c2
> [create_qp, 1399], pd: 00000000d8facf77

I don't know what you are trying to explain. You allocated a PD on
handle 0 and asked for a PD on handle 0 - and got back the same
pointer.

What is the problem?

> Now, if a rogue application tries to create a QP using a different
> PD other than the above two but it's pd_handle "HAPPENS" to match
> one of the above:

The xarray that holds the handles is scoped inside the ib_uverbs_file
- which is unique per file descriptor. A "rouge application" cannot
access handles outside its file descriptor.

Jason
