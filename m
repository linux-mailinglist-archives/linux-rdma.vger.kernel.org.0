Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DA242A91D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Oct 2021 18:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhJLQMH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Oct 2021 12:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhJLQMH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Oct 2021 12:12:07 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9220AC061570
        for <linux-rdma@vger.kernel.org>; Tue, 12 Oct 2021 09:10:05 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id z15so13156423qvj.7
        for <linux-rdma@vger.kernel.org>; Tue, 12 Oct 2021 09:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tFvy3ubvMfhHk+g9e8l9CkcbPDBb3uSrt6VFI2Ju7nw=;
        b=HAd5udS1ZXAsjCUX6zWDYrtjFSVpuMV0L4yD04Vp6Kvy4Q/u/rNCIhzlTmke7uo5dH
         +PwSgTNZD2I4Gc0jkNNN7QXId3GD1xB/iXxfx73T+AtwTsrA0bsm/Uqz8bOrGeOTMtLx
         m50N1Uw3e/L21BC0PNUIDkRZKmQR5wCMbu3TgSdPOwmPzf9v7Ll+gfySxmGhN8m7pDkf
         ZwsPJz4gLKnT5lR01E4AdhEkE7FJus/eivUEhUPRpTgq4+xzmsvVXgXXlGP/heD5SXws
         +TbTZ1nPM5hiAf6i8husr2O8KFHInnIKsj98riovHyNRWeXvCnRv6UzwVcqjhSlTnvgJ
         SQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tFvy3ubvMfhHk+g9e8l9CkcbPDBb3uSrt6VFI2Ju7nw=;
        b=wmkpG71UV22QLeeDsxKQEHWme8VmgzQ2qLAnxYlpEG9uWoLM8dGsb8Y/qmwCv+4l0Y
         XFjNn7bTaYi1cVJaq1LTpQl3n++UYuDexi/B2+FbtwPp/Raa76qggrF1tV6AyCJWoDim
         xrUfxfNAySahD93P5IyKg+Lbih8wmKV5iML0RtWTUxP3vtqr2QlxKYVaCBXkeUnCIQle
         QSpcLBz8KbgBPr7x+40gV+uzbnmmrZvHhSFHJW6I3H/g6qaOPcDNw6Ot1ZwOfd1CQXOb
         z9JRsTE/xqIAJ7ss2FeFkpbMRhQlPfHsXvLBjrMrR/bTwYlXnE5mMB4JVBE+Z979+N8U
         EAOA==
X-Gm-Message-State: AOAM531nJY1pazHQBpc1pwiIXHQH08wlw2pbbOyTAMe7brjeQscjtDhd
        7/IDjeaiOQM5mQp39vT2xKNUlg==
X-Google-Smtp-Source: ABdhPJyNgUdZ+ADUISbJNrbkfZE5JfdrbORMANvAhpVJVpC4lhYxIo+pfPV3uTibSEibQTwyUTCzqg==
X-Received: by 2002:a05:6214:448:: with SMTP id cc8mr30602859qvb.28.1634055002550;
        Tue, 12 Oct 2021 09:10:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id f77sm3068776qke.133.2021.10.12.09.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 09:10:01 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1maKLp-00E9EV-7i; Tue, 12 Oct 2021 13:10:01 -0300
Date:   Tue, 12 Oct 2021 13:10:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Devale, Sindhu" <sindhu.devale@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>
Subject: Re: Question on PD validation
Message-ID: <20211012161001.GK2688930@ziepe.ca>
References: <SA2PR11MB495343C46850C730BA4203C1F3B59@SA2PR11MB4953.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA2PR11MB495343C46850C730BA4203C1F3B59@SA2PR11MB4953.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 11, 2021 at 11:05:02PM +0000, Devale, Sindhu wrote:
> Hi all,
> 
> Currently, when an application creates a PD, the ib uverbs creates a PD uobj resource and tracks it through the xarray which is looked up using an uobj id/pd_handle. 
> 
> If a user application were to create a verb resource, example QP, with some random ibv_pd object  [i.e. one not allocated by user process], whose pd_handle happens to match the id of created PDs, the QP creation would succeed though one would expect it to fail For example:
> During an alloc PD:
> irdma_ualloc_pd, 122], pd_id: 44, ibv_pd: 0x8887c0, pd_handle: 0 
> 
> During create QP:
> [irdma_ucreate_qp, 1480], ibv_pd: 0x8889f0, pd_handle: 0
> 
> 
> Clearly, the ibv_pd that the application wants the QP to be
> associated with is not the same as the ibv_pd created during the
> allocation of PD. Yet, the creation of the QP is successful as the
> pd handle of 0 matches.

Most likely handle 0 is a PD, generally all uobj's require a PD to be
created so PD is usually the thing in slot 0.

The validation that the index type matches is done here:

	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_PD_HANDLE,
			UVERBS_OBJECT_PD,
			UVERBS_ACCESS_READ,
			UA_OPTIONAL),
Which is passed into this:

static int uverbs_process_attr(struct bundle_priv *pbundle,
			       const struct uverbs_api_attr *attr_uapi,
			       struct ib_uverbs_attr *uattr, u32 attr_bkey)
{
	case UVERBS_ATTR_TYPE_IDR:
		o_attr->uobject = uverbs_get_uobject_from_file(
			spec->u.obj.obj_type, spec->u.obj.access,
			uattr->data_s64, &pbundle->bundle);

Which eventually goes down into this check:


struct ib_uobject *rdma_lookup_get_uobject(const struct uverbs_api_object *obj,
					   struct ib_uverbs_file *ufile, s64 id,
					   enum rdma_lookup_mode mode,
					   struct uverbs_attr_bundle *attrs)
{

		if (uobj->uapi_object != obj) {
			ret = -EINVAL;
			goto free;
		}

Which check the uobj the user provided is the same type as the schema
requires.

The legacy path is similar, we start here:

		pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd->pd_handle,
				       attrs);

Which also calls rdma_lookup_get_uobject() and does the same check.

Jason
