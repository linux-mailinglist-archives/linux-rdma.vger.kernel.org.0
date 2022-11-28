Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A73463A1FC
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Nov 2022 08:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiK1He3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Nov 2022 02:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK1He2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Nov 2022 02:34:28 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F47E0CD
        for <linux-rdma@vger.kernel.org>; Sun, 27 Nov 2022 23:34:27 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v1so15284997wrt.11
        for <linux-rdma@vger.kernel.org>; Sun, 27 Nov 2022 23:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MHHiTWSbIumd9i/1CR+3bFaBxhyp1paPVyGE0awhPoo=;
        b=WjiFcw5IWGGwTGan8DSUvyWpR2xfdTwoNa+Pk4ciYbezQZp8EL/4VrZ4HuWJscuOzZ
         oG9sNSEQK2Dtx61EWvpRVhHyJY/vvxnEAMYExw/I4MckpnDbFHhFRfRY6eTDR1qepj5e
         GhUB7Yw6r96wlJ6BMJuN8IVkQEIEaRWSXOtqGbrm12RUv/Uir68AGH0SY0z001PgLRk7
         nbIt5DtPMSXsSGT7Tz3Rou+vDjQcZpYv9eBnL1Bbdy96zA1oKwa9lxKMfKREyYdyttg7
         IC/hlnqTTm00jfwo4g4F6ECjCzdSu2PyEijyyLxcxPionDBOHkaX0h+IMD/xoFRgnaHX
         IXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHHiTWSbIumd9i/1CR+3bFaBxhyp1paPVyGE0awhPoo=;
        b=LSdZuY4er5CprrPnWjwvxOYlO71sXvnKV5/9Y5ywbl3SnJ0A8kZI+PO/4nyqAA0Q/4
         ISbHBneHKsjgvs6H49AN9CR4Iznb9m4n6RoE7ZKkB3lvtM88vWC5WIu9bgmqWYfVxjLD
         5hKBSgFKh7LPuiPDvwEV1HwuK4zdvdiHbpXZrmU1k54slRnqcvmV+Jcb+kCgR4Z6rlka
         8DoopL8WCup4EyEfhr7/2h+HlhlFCAGRtRQDyU3yDpmYOyGcUN+PwVklwHgOzSReh3vs
         ZRSafDT5EX3FrPgU41GxfTJT1yRuPiEvEjWmydGx6vpox/8gs1pBOIiDu2IWBdm7Gh1a
         bgFQ==
X-Gm-Message-State: ANoB5pmWHUYzmuotWcHRxwTRNzJ/322muxtZWY/djj3CX0AAYGh0tVGs
        yLk7ivUt3Xz/NjzQGVQkGUY=
X-Google-Smtp-Source: AA0mqf7W+493hXStlEtL+E2D169+dS/PWwof5HYgQLihqraI0836NVXR43/C3cZJBjOyoJcpQ+eAGA==
X-Received: by 2002:adf:dd42:0:b0:242:127d:406d with SMTP id u2-20020adfdd42000000b00242127d406dmr3691851wrm.328.1669620866288;
        Sun, 27 Nov 2022 23:34:26 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q6-20020a1c4306000000b003cf774c31a0sm17337771wma.16.2022.11.27.23.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 23:34:25 -0800 (PST)
Date:   Mon, 28 Nov 2022 10:34:17 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [bug report] iwpm: crash fix for large connections test
Message-ID: <Y4RkeS9mlTl9uBnO@kadam>
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

So the background here is that Smatch sees this:

	kref_put(&nlmsg_request->kref, iwpm_free_nlmsg_request);

and correctly says "if we call iwpm_free_nlmsg_request() then
dereferencing nlmsg_request is a use after free".  However, the code
is holding two references at this point so it will never call
iwpm_free_nlmsg_request().

Smatch already checks to see if we are holding two references, but it
doesn't parse this code correctly.  Smatch could be fixed, but there are
other places with similar warnings that are more difficult to fix.

What we could do is create a kref_no_release() function that just calls
WARN().  This would silence the warning and, I think, this would make
the code more readable.

What do other people think?

regards,
dan carpenter

diff --git a/include/linux/kref.h b/include/linux/kref.h
index d32e21a2538c..f40089f61aa6 100644
--- a/include/linux/kref.h
+++ b/include/linux/kref.h
@@ -45,6 +45,11 @@ static inline void kref_get(struct kref *kref)
 	refcount_inc(&kref->refcount);
 }
 
+static inline void kref_no_release(struct kref *kref)
+{
+	WARN(1, "Unexpected kref release");
+}
+
 /**
  * kref_put - decrement refcount for object.
  * @kref: object.
diff --git a/drivers/infiniband/core/iwpm_msg.c b/drivers/infiniband/core/iwpm_msg.c
index 3c9a9869212b..1acb96bfaf9c 100644
--- a/drivers/infiniband/core/iwpm_msg.c
+++ b/drivers/infiniband/core/iwpm_msg.c
@@ -432,7 +432,7 @@ int iwpm_register_pid_cb(struct sk_buff *skb, struct netlink_callback *cb)
 register_pid_response_exit:
 	nlmsg_request->request_done = 1;
 	/* always for found nlmsg_request */
-	kref_put(&nlmsg_request->kref, iwpm_free_nlmsg_request);
+	kref_put(&nlmsg_request->kref, kref_no_release);
 	barrier();
 	up(&nlmsg_request->sem);
 	return 0;
@@ -504,7 +504,7 @@ int iwpm_add_mapping_cb(struct sk_buff *skb, struct netlink_callback *cb)
 add_mapping_response_exit:
 	nlmsg_request->request_done = 1;
 	/* always for found request */
-	kref_put(&nlmsg_request->kref, iwpm_free_nlmsg_request);
+	kref_put(&nlmsg_request->kref, kref_no_release);
 	barrier();
 	up(&nlmsg_request->sem);
 	return 0;
@@ -602,7 +602,7 @@ int iwpm_add_and_query_mapping_cb(struct sk_buff *skb,
 query_mapping_response_exit:
 	nlmsg_request->request_done = 1;
 	/* always for found request */
-	kref_put(&nlmsg_request->kref, iwpm_free_nlmsg_request);
+	kref_put(&nlmsg_request->kref, kref_no_release);
 	barrier();
 	up(&nlmsg_request->sem);
 	return 0;
@@ -801,7 +801,7 @@ int iwpm_mapping_error_cb(struct sk_buff *skb, struct netlink_callback *cb)
 	nlmsg_request->err_code = err_code;
 	nlmsg_request->request_done = 1;
 	/* always for found request */
-	kref_put(&nlmsg_request->kref, iwpm_free_nlmsg_request);
+	kref_put(&nlmsg_request->kref, kref_no_release);
 	barrier();
 	up(&nlmsg_request->sem);
 	return 0;
