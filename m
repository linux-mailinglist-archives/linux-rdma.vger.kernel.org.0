Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226797B8ABD
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Oct 2023 20:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244378AbjJDSid (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Oct 2023 14:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244424AbjJDSid (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Oct 2023 14:38:33 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13079C1
        for <linux-rdma@vger.kernel.org>; Wed,  4 Oct 2023 11:38:27 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-693375d2028so83169b3a.2
        for <linux-rdma@vger.kernel.org>; Wed, 04 Oct 2023 11:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1696444706; x=1697049506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y+QybpvnWcMUHFWamWWgoSYeRr5EWCfldB053dx8YYc=;
        b=oXSCLu/K74W+msO0aNBAnBjdBkVfuAt4ZoyMjxFj2ZpRlo/xGQOdl5UYfpZu4OxpRm
         Qxj2ZMMv3mJS8CZ3ZOyuGailji1nORimiRFD5tGPfr9Jz1Z8hGFD855j/QLSpK4LXkcc
         Sepnc8HxOvfJkDqW9VcMFjCccswxPf65J9u01eIiUL+E1fTHXEa1wXZ5hvN+fN6glDtH
         Ox29muIUvfG6n/SIeuEM5h/sZDyAFyC7WL52Lhr8wlRsJ7zff2lykruFXS+aoj4hGUzO
         0uHTplOUAtNHEWjvUFAcUvw3iDPUnrxMXSiTl/MHdQQDb9G6q+rglAKi1OPuOg1yvVR5
         2LkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696444706; x=1697049506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+QybpvnWcMUHFWamWWgoSYeRr5EWCfldB053dx8YYc=;
        b=OrAdhHCObclyHSjp0yKjiRqTeY4cEweYKZZywcwhUqtBxAfmIAokMkcPpOhAR30PGe
         ulvg5SoJQB3Pscg4fH1Wa1p72HmXRXuZRmqCZ0VGqKo0iuZh/5X1Uhbu3lHdbQibACXO
         2jEP5Nj4B6Fwy/mwFHgSWagFibGlCZ2vxSTXxXtz6JNfyHJJeyYt2Sp2EwG3sF0b8G8z
         3Gi8xxaEcrcfjeAW3cBgXBjm8R6VNyTmBL47R0IeUM4XPDyKewZG37y56MJmvvhgwOHM
         /adtJRpbCW7P+zFqzVsVY13kfd6CH0lXBtapixOyHnvzLf8nWfQ1+ONmMemvpB8/43Ym
         KvqQ==
X-Gm-Message-State: AOJu0Ywksin+9g4EKfNREbnyRTqvhfIVAdLApFkfYXruaXD1IyGwrO3A
        XyQXN/GUSEHUwqAUjWnCl07Ksg==
X-Google-Smtp-Source: AGHT+IGxcYsU/Tr+/trlVN97mmF3WfDuOGVtAd9AFm9WHVd7DkEm4RjJJlCaZOqopIdHZPC9vFDeww==
X-Received: by 2002:a05:6a00:391b:b0:690:3793:17e5 with SMTP id fh27-20020a056a00391b00b00690379317e5mr3491268pfb.4.1696444706496;
        Wed, 04 Oct 2023 11:38:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id o4-20020a637304000000b0057765e00ebdsm3707127pgc.46.2023.10.04.11.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 11:38:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qo6lM-003r0k-4y;
        Wed, 04 Oct 2023 15:38:24 -0300
Date:   Wed, 4 Oct 2023 15:38:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, matsuda-daisuke@fujitsu.com,
        shinichiro.kawasaki@wdc.com, linux-scsi@vger.kernel.org,
        Zhu Yanjun <yanjun.zhu@intel.com>
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
Message-ID: <20231004183824.GQ13795@ziepe.ca>
References: <20230922163231.2237811-1-yanjun.zhu@intel.com>
 <169572143704.2702191.3921040309512111011.b4-ty@kernel.org>
 <20230926140656.GM1642130@unreal>
 <d3c05064-a88b-4719-a390-6bf9ae01fba5@acm.org>
 <b7b365e3-dd11-bc66-dace-05478766bf41@gmail.com>
 <2d5e02d7-cf84-4170-b1a3-a65316ac84ee@acm.org>
 <2fcef3c8-808e-8e6a-b23d-9f1b3f98c1f9@linux.dev>
 <552f2342-e800-43bc-b859-d73297ce940f@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <552f2342-e800-43bc-b859-d73297ce940f@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 04, 2023 at 10:43:20AM -0700, Bart Van Assche wrote:

> Thank you for having reported this. I'm OK with integrating the
> above change in my patch. However, code changes must be
> motivated. Do you perhaps have an explanation of why WQ_HIGHPRI
> makes the issue disappear that you observed?

I think it is clear there are locking bugs in all this, so it is not
surprising that changing the scheduling behavior can make locking bugs
hide

Jason
