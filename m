Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60609758A9D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jul 2023 03:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjGSBGR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jul 2023 21:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGSBGQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jul 2023 21:06:16 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBECD3
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jul 2023 18:06:15 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-78caeb69125so2306059241.3
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jul 2023 18:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge.com; s=google; t=1689728774; x=1690333574;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s48yXdFx+xPO4BrkWRgsMooEQsKPgfbQtrZDpMwL0iA=;
        b=YKp6/CNPWs4g50d8n6f45QXjNvv9MwzbK8Vo/hAirPAp+nQCRQqHaivrVvEATAj/5x
         LgEtOu+yWo6+z87mHhUq/fgkMgYj5IOlfgw+AiEN6Ip5WQQbGdhw2Z8K25emmh/o24jL
         Z17t2ngNUVziRTl7ZNEWw4u8dOpve85p4ljnZL6ID8RKfVYANxRVNwv2LYGeJ7hX9Kn7
         ycvlLmpywWZ/52lEDC4QXZpEiUaqaSOVgigFU8dISNZ4bL7igkxjwJpN0MrTXcX0Yacy
         uU8UETq96WzovYO97lvwQGMwTIseGWNTle30zlaiIXJR/cnokTCG37rUeqSfLkckpCm3
         eoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689728774; x=1690333574;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s48yXdFx+xPO4BrkWRgsMooEQsKPgfbQtrZDpMwL0iA=;
        b=W6W2FEXS5BGvnDu/Jb3ByWtcd1csvMb1e5v0vzaB1eQpoBERcndEhh7WTh3xR932BF
         RvXa+OqOBCSIR3fTMu29uvEbmRySBa2WclP/T4LV8+ZS9G9L8PLD0KneHtT/APs1M24D
         SsDsLyOkSeHqMVlET3wMt6dfrZTRop8b2dCzMZYTm6GAO4IToNPZisi6Gv65dM6PXe1J
         9/xarB6yjZRx2WZYM6G3qh9DFJXgBc1LsMpbo2nPRK5BqvCbFngHe+NubQPDkEFu4CPa
         ekH75r/QKjxHjr9RaULSOHNtmF6KDqHgy1iZBsxMKKpRf0wLMimCYW2/mjt43r7MLApS
         DXiw==
X-Gm-Message-State: ABy/qLbRvUS8CLCWQ6Aq9+E4GSS+K8/kTdFmJ2yDbrieODx1r0e2i5xU
        Ejuyhn9FqcIs/VMPVVQDuXMm0QoLjZZIXIstwBJK8L8/pe/b0t55yts=
X-Google-Smtp-Source: APBJJlFO7FshIuFKMltlGKR+OkHMYF0knI0osygVmuNvj8Xk2pSniZS4QEjWx5BQtSDikc2z31uCcNrkkLiRH2ptJxE=
X-Received: by 2002:a67:fd59:0:b0:443:873a:16b8 with SMTP id
 g25-20020a67fd59000000b00443873a16b8mr9090621vsr.30.1689728774295; Tue, 18
 Jul 2023 18:06:14 -0700 (PDT)
MIME-Version: 1.0
From:   Jonathan Nicklin <jnicklin@blockbridge.com>
Date:   Tue, 18 Jul 2023 21:05:38 -0400
Message-ID: <CAHex0cr5NVCpERLfudrTk-rhHez0uodnkbj5fp5X58zh3DFvfg@mail.gmail.com>
Subject: mlx5: set_roce_address() / GID add failure
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

I've encountered an unexpected error configuring RDMA/ROCEV2 with one of our
200G ConnectX6 NICS. This issue reproduces consistently on 5.4.249 and 6.4.3.

dmesg output:

[    9.863871] mlx5_core 0000:01:00.0: mlx5_cmd_out_err:803:(pid
1440): SET_ROCE_ADDRESS(0x761) op_mod(0x0) failed, status bad
parameter(0x3), syndrome (0x63c66), err(-22)
[    9.881250] infiniband mlx5_2: add_roce_gid GID add failed port=1 index=0
[    9.889095] __ib_cache_gid_add: unable to add gid
fe80:0000:0000:0000:ad3e:e3ff:fe92:b31b error=-22

Device Type:      ConnectX6
Part Number:      MCX653105A-HDA_Ax
Description:      ConnectX-6 VPI adapter card; HDR IB (200Gb/s) and 200GbE ...
PSID:             MT_0000000223
PCI Device Name:  0000:01:00.0

Firmware is up to date. LINK_TYPE is to ETH(2) and ROCE_CONTROL is
ROCE_ENABLE(2).

Has anyone seen this syndrome? Any advice or assistance is appreciated.

Thanks,
-Jonathan
