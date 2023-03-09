Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445CC6B2677
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Mar 2023 15:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCIOPE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Mar 2023 09:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjCIOO0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Mar 2023 09:14:26 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849D55B5DA;
        Thu,  9 Mar 2023 06:13:17 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id h3so1943818lja.12;
        Thu, 09 Mar 2023 06:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678371192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0L3e2Gc1woVMAVlvcEHWXDzcW7MDDTkeZvDGMyuHmDM=;
        b=ZiP8eNuayA+2CcmAR5fDLa1MnQvzgU7G68TvxH2IoGFLGtrWnjeJnXBLCh2l9HMstZ
         ZcsR2pVrQZXCuPdIwYjs2PQGRO1NtijEFZni5RC8W4tlLosV8KpxEq7s0N6vV/gFEKf+
         GbUCvkKR6j5GVeK/BomL0ZZ4n5k790VtN1eHSKO98Ly4i+jO7Qaxeo0ppAWkGEJ0A+0h
         gqpz0jvCe0A/WpvvHDtZ+6bYE0X8wGzle6tbA5HWQW4iZIVpogJE73oHPZyOExHxF4e6
         UJPH5y8H8psogpWsAxR/fziAK9q9SVCWYRO/u+278qkRguOSL1jH8yoNIkJpWZiVAcM7
         OYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678371192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0L3e2Gc1woVMAVlvcEHWXDzcW7MDDTkeZvDGMyuHmDM=;
        b=XnZI2WsVMJTjYrwqBBPIQwU2VHXlF4rHewRNpx/EY0JbqPBgtV/nXnhptMwVAIzX6M
         s3INjqxFgc4yvgGK/CwmGJ7i7VX6KfRR6fMwiiFa2vw4MLXPtqBP9SQDF6jtRu9pRE3b
         2C+t7sf9AA6LbnJ4DPg6l6l1w0qcJWcybnJVOyUcqNt0HUdjbWagYo93f2UNaSwaw/F2
         68916GYzoHQdTwB/KdWA0pnJNSmwOP8HcP5ENWG3nesfTVI7UYk9dZNSEJXR+orOUpau
         2C599D7xwmoNXZ4ZSKtRT7fEeKjAXqzteOiSOqVgVpbTeJ3oPKakr13gu36okoVPGRDF
         Id6g==
X-Gm-Message-State: AO0yUKXjcTNLzdVJ8GXkv0IrLa2vi3heJ+lUYSL2Mm7K4yH8XHx1otjr
        /yEzAAou5yNjvvxyj59+jnU=
X-Google-Smtp-Source: AK7set/wGRG6DZwH1goQYuwyWeVqUPotbXSii8soBGsA0hvgGcEXtX1zIA8XR5JqSVge5Z0JqI+ZpQ==
X-Received: by 2002:a2e:6109:0:b0:294:7028:c66a with SMTP id v9-20020a2e6109000000b002947028c66amr5600373ljb.38.1678371192149;
        Thu, 09 Mar 2023 06:13:12 -0800 (PST)
Received: from pc636 (host-95-193-108-241.mobileonline.telia.com. [95.193.108.241])
        by smtp.gmail.com with ESMTPSA id r19-20020a2e9953000000b00293534d9760sm2963887ljj.127.2023.03.09.06.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 06:13:11 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 9 Mar 2023 15:13:08 +0100
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 07/13] RDMA/rxe: Rename kfree_rcu() to
 kfree_rcu_mightsleep()
Message-ID: <ZAnpdKV/VvvX0TZz@pc636>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-8-urezki@gmail.com>
 <ZAnjnRC1wY3RIFhM@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAnjnRC1wY3RIFhM@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> On Wed, Feb 01, 2023 at 04:08:13PM +0100, Uladzislau Rezki (Sony) wrote:
> > The kfree_rcu()'s single argument name is deprecated therefore
> > rename it to kfree_rcu_mightsleep() variant. The goal is explicitly
> > underline that it is for sleepable contexts.
> > 
> > Please check the RXE driver in a way that a single argument can
> > be used. Briefly looking at it and rcu_head should be embed to
> > free an obj over RCU-core. The context might be atomic.
> > 
> > Cc: Bob Pearson <rpearsonhpe@gmail.com>
> > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  drivers/infiniband/sw/rxe/rxe_pool.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> Could you please add you reviwed-by or Acked-by tags so we can bring
> our series with renaming for the next merge window?
> 
> Thanks!
> 
__rxe_cleanup() can be called in two contexts, sleepable and not.
Therefore usage of a single argument of the kvfree_rcu() is not correct
here.

Could you please fix and check your driver? If my above statement
is not correct, please provide Acked-by or Reviwed-by tags to the
path that is in question.

Otherwise please add an rcu_head in your data to free objects over
kvfree_rcu() using double argument API.

Could you please support?

--
Uladzislau Rezki
