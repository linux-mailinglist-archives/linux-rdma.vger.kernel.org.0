Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FD8630CF8
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Nov 2022 08:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiKSHbp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Nov 2022 02:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKSHbp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Nov 2022 02:31:45 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4670A65B3
        for <linux-rdma@vger.kernel.org>; Fri, 18 Nov 2022 23:31:43 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l14so12674218wrw.2
        for <linux-rdma@vger.kernel.org>; Fri, 18 Nov 2022 23:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tdMiT9KIVrQ4a/18NF6oISWHHiuMnB86uoBSbexyVh0=;
        b=BWSYNNG5jjhj4hOzDTUYLk66Ou+K97SEj0NJx7imyUQKnFCsWgSwv2ZXgoDcrsCUyO
         kSdV+tJrvbHaf/4DFckD2h78yebnMFMp+NAWcAGeL6wOFEx1fzi7AcqrryMrRs3KSOtL
         JSFEPB95tlSzY7f/iB5lw17KGvsiu7MSDSUuQi3+aOCtM5ovpJgQpap48sDPYOgAe/E6
         VY8x9tanywary8ik6qJDbu8bgTrG/kGJQrJS4u02dMftDcr2yv275LsKFCRd1ruv2KW0
         Waj0l6J+KfnmeV10Soy+inMA+Bfw5iqVfNrmNorVH+XHUz5yNLCviZEJvnBuAykWEd6b
         6ALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdMiT9KIVrQ4a/18NF6oISWHHiuMnB86uoBSbexyVh0=;
        b=GFMZm/gH/3Xpma5tDQzgoEqpL/Gu4RU17bxGCUzFdfKrlNsLdPmmyCnYBvsiHrXdG+
         DPXgvw6PWWG5N2KC8xUC5bvxjIZzwy/P5nFWgYd8Xep0oN2nw8Mez15PNsFYBdnP2Q5z
         pD6BbEababiSWEvEt1s2RTidj1bl9ghqKQ5vBdQobxuzGtW30tYASL2uT1nE40OKe7K5
         8GqWLNJaSVW2fcYOfY1We6LU74TN5cjcxtieGGreSr7DxqSByfbSCa3xvp9YoXJENkLA
         HiG7jG2w0S4kCXnP7LpnSzk0jZQaoBFxmBbjM7XpeLfOdM/6KJtm3PCy0m71Gj0ujT+F
         aMrg==
X-Gm-Message-State: ANoB5plu4feWTwkvidKJhDO0RcaOXrwtkdMRNn0VyPfjYc/dvly07173
        tYwlYODZ33bUylK1SW3DFLfZwc051rSQRQ==
X-Google-Smtp-Source: AA0mqf7j9ftAz3S5cuCgvOQOwpB16fINnmIjSfGpgcNSpW5PoSRikyZT1ABnrx924tGq+2NQmU23oA==
X-Received: by 2002:a5d:54d2:0:b0:241:c224:201e with SMTP id x18-20020a5d54d2000000b00241c224201emr3426350wrv.43.1668843102134;
        Fri, 18 Nov 2022 23:31:42 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h5-20020a5d6885000000b002366b17ca8bsm6228912wru.108.2022.11.18.23.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 23:31:41 -0800 (PST)
Date:   Sat, 19 Nov 2022 10:31:38 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     "Ismail, Mustafa" <mustafa.ismail@intel.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [bug report] iwpm: crash fix for large connections test
Message-ID: <Y3iGWkLzqm3B4ttV@kadam>
References: <Y3ORbHXv5M8X8kqN@kili>
 <Y3X91h5Fla+4mICY@unreal>
 <PH7PR11MB640377FDDE4E242D31DE063E8B099@PH7PR11MB6403.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB640377FDDE4E242D31DE063E8B099@PH7PR11MB6403.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 18, 2022 at 08:44:11PM +0000, Ismail, Mustafa wrote:
> > >     432 register_pid_response_exit:
> > >     433         nlmsg_request->request_done = 1;
> > >     434         /* always for found nlmsg_request */
> > >     435         kref_put(&nlmsg_request->kref, iwpm_free_nlmsg_request);
> > >
> > > The iwpm_free_nlmsg_request() function will free "nlmsg_request"...
> > > It's not clear what the "/* always for found nlmsg_request */" comment
> > > means.  Maybe it means that the refcount won't drop to zero so the
> > > free function won't be called?
> > 
> > I think so. The nlmsg_request reference counter is elevated when it is found
> > in iwpm_find_nlmsg_request(). So I assume that it will be at least
> > 2 before call to kref_put(). Most likely, nlmsg_request->sem prevents from
> > parallel threads to decrease that reference counter.
> > 
> 
> I agree with Leon. The ref count should be 2 here.
> However, I don't see why the kref_put() can't be moved after the up(&nlmsg_request->sem) to get rid of the warning.
> 

Let's not expend too much time trying to silence this warning.  One way
to silence the warning would be to do:

	kref_put(&nlmsg_request->kref, NULL);

I'm conficted about this approach, but no good can come from calling
iwpm_free_nlmsg_request() on this path.

A better way to silence the warning would be to do:

diff --git a/drivers/infiniband/core/iwpm_util.c b/drivers/infiniband/core/iwpm_util.c
index 358a2db38d23..4f819e6c1b09 100644
--- a/drivers/infiniband/core/iwpm_util.c
+++ b/drivers/infiniband/core/iwpm_util.c
@@ -357,7 +357,7 @@ struct iwpm_nlmsg_request *iwpm_find_nlmsg_request(__u32 echo_seq)
 			    inprocess_list) {
 		if (nlmsg_request->nlmsg_seq == echo_seq) {
 			found_request = nlmsg_request;
-			kref_get(&nlmsg_request->kref);
+			kref_get(&found_request->kref);
 			break;
 		}
 	}

But the best way would be to make Smatch parse iwpm_find_nlmsg_request()
correctly as-is.

regards,
dan carpenter

