Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B26777A6D6
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Aug 2023 16:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjHMOSv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Aug 2023 10:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHMOSu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Aug 2023 10:18:50 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F45E1725
        for <linux-rdma@vger.kernel.org>; Sun, 13 Aug 2023 07:18:49 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4fe8f602e23so1358638e87.1
        for <linux-rdma@vger.kernel.org>; Sun, 13 Aug 2023 07:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691936328; x=1692541128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=moIl+TOj2IFY41LtwWffbMqLdrbl4BZ9G003u1QU10E=;
        b=BQbsp3xGNGYfNQMIvovIhAV4F8GhfWlaA5GlpsufIpQ3gx/tWBOmO1qL+wwNctX5CG
         s0lrpmP5ElOf9BzNfVOfI+3BNutjWH8d9hNFd43dLmM/MoDJNwK6UzzbO4H7d5IvtTOB
         xsy2XqlwXwYU93Sfhk0HZaN87xr6Iel/Tf39yObZH92YrLOV3dkE6uqrU5ckkP+MJkDB
         X7sFP5oz2altpwv4ZidGAQc9Sb8MGrm2HMS6xG9aUuO6Wnq8GtZ8tg+jxMKm6j/HnEEW
         9efo+O1QtukCAV2o1Yg10R06a1Ebn7mT59tQfYfmoPxbCzFjn3WmFz0PfVREm3ecqFxX
         1B9g==
X-Gm-Message-State: AOJu0Ywhc9wm6xvI9BYzdZoweEjJxl+N7dkrmUWPziP9mzRGMy12qyuC
        DLsIGN3t27cdTYF4uXqerPg=
X-Google-Smtp-Source: AGHT+IHm2/HQLBIIAoUOjhIg/iK3qaXebDAms4OeRfPLulHRCTBhE1TJk5KWgS5TXrPohOE9BH6wfQ==
X-Received: by 2002:ac2:519a:0:b0:4fd:cab4:7d15 with SMTP id u26-20020ac2519a000000b004fdcab47d15mr3047534lfi.2.1691936327562;
        Sun, 13 Aug 2023 07:18:47 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id o27-20020a17090637db00b0099bc8db97bcsm4625794ejc.131.2023.08.13.07.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 07:18:46 -0700 (PDT)
Message-ID: <91d94243-3741-0098-cd3c-a6ebc8f21cf2@grimberg.me>
Date:   Sun, 13 Aug 2023 17:18:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: isert patch leaving resources behind
Content-Language: en-US
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Cc:     Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>,
        saravanan.vajravel@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>
References: <921cd1d9-2879-f455-1f50-0053fe6a6655@cornelisnetworks.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <921cd1d9-2879-f455-1f50-0053fe6a6655@cornelisnetworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 8/10/23 17:44, Dennis Dalessandro wrote:
> Commit: 699826f4e30a ("IB/isert: Fix incorrect release of isert connection") is
> causing problems on OPA when we try to unload the driver after doing iSCI
> testing. Reverting this commit causes the problem to go away. Any ideas? Was
> testing done on this patch with removing/hotplugging drivers?

You are correct, the patch is wrong because it doesn't fully release the
connection in ib device surprise removals.

Perhaps this should address this issue?
--
diff --git a/drivers/infiniband/ulp/isert/ib_isert.c 
b/drivers/infiniband/ulp/isert/ib_isert.c
index 92e1e7587af8..274ac9361fe7 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2570,6 +2570,9 @@ static void isert_wait_conn(struct iscsit_conn *conn)
         isert_put_unsol_pending_cmds(conn);
         isert_wait4cmds(conn);
         isert_wait4logout(isert_conn);
+
+       isert_put_conn(isert_conn);
+       conn->context = NULL;
  }

  static void isert_free_conn(struct iscsit_conn *conn)
--
