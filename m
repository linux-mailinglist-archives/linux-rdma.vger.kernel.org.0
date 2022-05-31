Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D585C5395AA
	for <lists+linux-rdma@lfdr.de>; Tue, 31 May 2022 19:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244690AbiEaRzu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 May 2022 13:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343748AbiEaRzt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 May 2022 13:55:49 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC24C9AE70
        for <linux-rdma@vger.kernel.org>; Tue, 31 May 2022 10:55:48 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id n10so14436993pjh.5
        for <linux-rdma@vger.kernel.org>; Tue, 31 May 2022 10:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=dCJ0kxoNhxlaN6HUzh28+2u9bgLInd78a4P4vS2peww=;
        b=tSyQw+C00XSaJ6BZ4SpwjHNcdA4dQFYXZN2C0p2IFcbbQC4Y3dyyxhcXnWRx3SKm0H
         EXNlOBNtuS58MgLFUxMzrdHt6gl/Fq+owV3tMuz0FS7CzrOEkBzozxaQZWCLA0ri3BUN
         gL+QroaJWjNFMOwez0rm2xeBmcvdg7CfhwMfoJKp+w53C2bWRglzaOD9bAMCehbDtpHG
         kz28rtO7Qf8h2uu6Xlrog7vCGNuBXze6em6eaimYmVToEundni9v31ciGg7StXppKYkO
         mNlk/kWJ52lwGE7T9joKMgFYaF+A7vvTFm4ZxjCEt1cYvhcE90CJyWo6B0nyM/yFM528
         QCrA==
X-Gm-Message-State: AOAM531UAF7aZWtbLAumW40ScVMN65vkbtQPwP292Acg0qdcpqZF9/ra
        TPl3bnFIWxMnMd5kZWEhGe4=
X-Google-Smtp-Source: ABdhPJwExwLDU+mzF/g9QchT/DTKC6Kf2nIjCtULXhjUroLBP/wbJMwEwdhtw402flcK9Weu66IRnA==
X-Received: by 2002:a17:902:da8e:b0:164:537:d910 with SMTP id j14-20020a170902da8e00b001640537d910mr4413681plx.75.1654019748170;
        Tue, 31 May 2022 10:55:48 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id x27-20020aa78f1b000000b0051b8987efc0sm1874597pfr.218.2022.05.31.10.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 10:55:47 -0700 (PDT)
Message-ID: <355f1926-9a0d-f65e-d604-6b452fa987e9@acm.org>
Date:   Tue, 31 May 2022 10:55:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
 <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
 <4f15039a-eae1-ff69-791c-1aeda1d693df@acm.org>
 <20220527125229.GC2960187@ziepe.ca>
 <4d65a168-c701-6ffa-45b9-858ddcabbbda@acm.org>
 <20220531123544.GH2960187@ziepe.ca>
Content-Language: en-US
In-Reply-To: <20220531123544.GH2960187@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/31/22 05:35, Jason Gunthorpe wrote:
> On Sat, May 28, 2022 at 09:00:16PM +0200, Bart Van Assche wrote:
>> On 5/27/22 14:52, Jason Gunthorpe wrote:
>>> That only works if you can detect actual different lock classes during
>>> lock creation. It doesn't seem applicable in this case.
>>
>> Why doesn't it seem applicable in this case? The default behavior of
>> mutex_init() and related initialization functions is to create one lock
>> class per synchronization object initialization caller.
>> lockdep_register_key() can be used to create one lock class per
>> synchronization object instance. I introduced lockdep_register_key() myself
>> a few years ago.
> 
> I don't think this should be used to create one key per instance of
> the object which would be required here. The overhead would be very
> high.

Are we perhaps referring to different code changes? I'm referring to the
code change below. The runtime and memory overhead of the patch below
should be minimal.

Thanks,

Bart.


diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index fabca5e51e3d..d476c64cd84a 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -860,6 +860,8 @@ __rdma_create_id(struct net *net, rdma_cm_event_handler event_handler,
  	init_completion(&id_priv->comp);
  	refcount_set(&id_priv->refcount, 1);
  	mutex_init(&id_priv->handler_mutex);
+	lockdep_register_key(&id_priv->handler_key);
+	lockdep_set_class(&id_priv->handler_mutex, &id_priv->handler_key);
  	INIT_LIST_HEAD(&id_priv->device_item);
  	INIT_LIST_HEAD(&id_priv->listen_list);
  	INIT_LIST_HEAD(&id_priv->mc_list);
@@ -1899,12 +1901,16 @@ static void _destroy_id(struct rdma_id_private *id_priv,
  	cma_id_put(id_priv);
  	wait_for_completion(&id_priv->comp);

+	mutex_destroy(&id_priv->handler_mutex);
+	lockdep_unregister_key(&id_priv->handler_key);
+
  	if (id_priv->internal_id)
  		cma_id_put(id_priv->id.context);

  	kfree(id_priv->id.route.path_rec);

  	put_net(id_priv->id.route.addr.dev_addr.net);
+
  	kfree(id_priv);
  }

diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
index 757a0ef79872..4affecd044eb 100644
--- a/drivers/infiniband/core/cma_priv.h
+++ b/drivers/infiniband/core/cma_priv.h
@@ -75,6 +75,7 @@ struct rdma_id_private {
  	struct completion	comp;
  	refcount_t refcount;
  	struct mutex		handler_mutex;
+	struct lock_class_key	handler_key;

  	int			backlog;
  	int			timeout_ms;
