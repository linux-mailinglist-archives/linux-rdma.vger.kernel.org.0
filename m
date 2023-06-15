Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A29A731D44
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jun 2023 18:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjFOQBv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Jun 2023 12:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjFOQBl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Jun 2023 12:01:41 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D867F10F6
        for <linux-rdma@vger.kernel.org>; Thu, 15 Jun 2023 09:01:40 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1a98a7fde3fso1394844fac.3
        for <linux-rdma@vger.kernel.org>; Thu, 15 Jun 2023 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686844900; x=1689436900;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/j4YgOc90phcN8HZeCzmFlCALD6azJosWPedk2bJME=;
        b=n+zXFBznRZuPUpWjj7BFx1gxt1vm1lXLo2BHtksHgCI1EVAb/V2+Efsy04TL+AtPHK
         3nV47/uItxVYqHMckhqeymNy9HVsu5V2kDsC2R91/jyGyiPbDSgyGOARc9FlWgluKnWj
         1zGGUqpn4PhW5soP3ioSCrEJ0A0VUyUzlqICgC1dsP0rVhwukKQXABWU/zuPShcrHFH1
         kWiPBBa/GBbAwOhRP9bKONAhLkwWAFx6TmtvIWLvz2WcQ2nq5PqGraTfjckToJumT737
         gofHU1oMPFXT45KERCybY5BXloHemkRtoGiZ18Snph/H2oAkfGlrcVF3LNH51gaeOSB7
         gaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686844900; x=1689436900;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5/j4YgOc90phcN8HZeCzmFlCALD6azJosWPedk2bJME=;
        b=Vqef+4cbEjrtbFqKJhuzI+9BD8p7lYvZQCnCvriYT3WE28sYrrNJ34I5oIB1xr3l+N
         QQOsNqgxwMFRgs+2OtQRcZXdC1SPb8rNhfijdaZPpjBgxkhwWvcvReZimBVHWlIJxFqy
         LxiJzRiawdKMUk5A8uwEPZxhd0ahZHFazmXAO/rsB1bWF1ZneDzGu3Voz/ek3pVnSAl9
         bkxT2+9hSKl+bCLqFOhG2vx3ilXF/uBsKiXUVngg21ljqyNXjGpJtiB5OED4mm8+rhld
         pcAjGYAcc9HcHhAq5sw9GOh/3hrQ4YbQUloFrGcF1iKxWfE560RjPcAHoIyUaJNQCJZ/
         mdkg==
X-Gm-Message-State: AC+VfDwsnjJhQQo0YAeTDMosZ+ES15WRY4PDOlXvzCsMJZJkoila91NF
        eu6qK9TlzHAtaj6wKtjk4VA=
X-Google-Smtp-Source: ACHHUZ7upLaTaJv9XEIPWUifLOm4+cjrDhj6QtEq403lE6y11N2b6aL+QEx4FzLMl3lJDjzzPfm4VQ==
X-Received: by 2002:a05:6870:b7b2:b0:19e:eb89:bbee with SMTP id ed50-20020a056870b7b200b0019eeb89bbeemr15066436oab.8.1686844899952;
        Thu, 15 Jun 2023 09:01:39 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:494e:c8d0:f70:711a? (2603-8081-140c-1a00-494e-c8d0-0f70-711a.res6.spectrum.com. [2603:8081:140c:1a00:494e:c8d0:f70:711a])
        by smtp.gmail.com with ESMTPSA id v8-20020a05687105c800b001a6c1fcf1d6sm3440085oan.18.2023.06.15.09.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 09:01:39 -0700 (PDT)
Message-ID: <8bbd8118-ef8f-f156-6b13-f317bc90de58@gmail.com>
Date:   Thu, 15 Jun 2023 11:01:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     "Hack, Jenny (Ft. Collins)" <jhack@hpe.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: shared variables between requester and completer threads - a concern
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I am still on a campaign to tighten the screws in the rxe driver. There are a lot of variables that are shared
between the requester task and the completer task (now on work queues) that control resources and error recovery.
There is almost no effort to make sure changes in one thread are visible in the other. The following is a summary:

				In requester task		In completer task
	qp->req.psn			RW				R
	qp->req.rd_atomic (A)		RW				W
	qp->req.wait_fence		W				RW
	qp->req.need_rd_atomic		W				RW
	qp->req.wait_psn		W				RW
	qp->req.need_retry		RW				RW
	qp->req.wait_for_rnr_timer	RW				W

These are all int's except for rd_atomic which is an atomic_t and all properly aligned.
Several of these are similar to wait_fence:

				if (rxe_wqe_is_fenced(qp, wqe) {
					qp->req.wait_fence = 1;
					goto exit; (the task thread)
				}
						...
								// completed something
								if (qp->req.wait_fence) {
									qp->req.wait_fence = 0;
									rxe_sched_task(&qp->req.task);
									// requester will run at least once
									// after this
								}

As long as the write and read actually get executed this will work eventually because the caches are
coherent. But what if they don't? The sched_task implies a memory barrier before the requester task
runs again but it doesn't read wait_fence so it doesn't seem to matter.

There also may be a race between a second execution of the requester re-setting the flag and the completer
clearing it since someone else (e.g. verbs API could also schedule the requester.) I think the worst
that can happen here is an extra rescheduling which is safe.

Could add an explicit memory barrier in the requester or matched smp_store_release/smp_load_acquire,
or a spinlock, or WRITE_ONCE/READ_ONCE. I am not sure what, if anything, should be done in this case.
It currently works fine AFAIK on x86/x64 but there are others.

Thanks for your advice.

Bob
