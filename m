Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE84957BCF1
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jul 2022 19:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiGTRmB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jul 2022 13:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGTRmB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Jul 2022 13:42:01 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6814B43E46
        for <linux-rdma@vger.kernel.org>; Wed, 20 Jul 2022 10:42:00 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-31e1ecea074so105285567b3.8
        for <linux-rdma@vger.kernel.org>; Wed, 20 Jul 2022 10:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2X8HXtEcU/ZehxuPCgIPz4aOGr6MXTRGr5kvCe3jveI=;
        b=qJf5kPtScAdUlkTNjuKSESynUMGUhkrAI4Ca/2aJiOZjNFXCX2RKU0p5ZD6NiV0tsY
         S5lGtkwOJTSXaqBf+VlyFXKIBUPxTqfOU/QMMnR1fP0vLms+dwUWKBM/KkMBLBjLc5qQ
         Ts29nDLVRwT8wSfa44cUfU9QrJbONVw300PJIPM8R9oW1mRBWsPT8Tp3SkYf5dBzE7hN
         CLOCYkS64Frc2Bi1BKbtZYDsTeRg3YI5mBeNG22kW3xoDMC30hgvG2yr4rwuMM4AZXl8
         hVoKL41970Mcqmq33SjhEgokf43lgaBrM09eXsnLlY+eSAEyTF+1GXvy4btUg8X/o/0e
         eKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=2X8HXtEcU/ZehxuPCgIPz4aOGr6MXTRGr5kvCe3jveI=;
        b=iYB7jrbNcBkoTt17YxhCbCo0gFcTMPHX/6cM9aQ9puK4H6y9TugZNMpHdy5J2t6y5z
         FSQgJcBD9mPS3RMOmxQ3sHdFV5rpKGYqTQXij31RuprJkDpGCVX5ggrzxnDkAP0tFu9A
         XwZLMmDHaH/t5hmK/l2wvuT5EqSi0IDKC/a25WZdjJwzub78KVbz3VpnOYxG8tdP0zmI
         hx2J4zpxL2Ct0LvMzX3eem2+93D0ee2MWKytVEtD1NZSCaGyPTqqTR/0tQ/9uVUqe6QP
         I3SYuCxV1Hk0R76J9OHNoK2PiS+YZMsS4iUZcerAcjpmJOa6rFkR6TKhQKqxCYBoSYyH
         Cu9g==
X-Gm-Message-State: AJIora/76lVvquHAyrML/VPwdSLvhvh6CGjnK2UEU7dDit5I771VMTC5
        ra2RBwtOptHPFLXkKqGE8oo/xSUAH4RRBbvCz+g=
X-Google-Smtp-Source: AGRyM1uJgch5tZBtq7ZNZxzaBCqHBPG8c0/bMwS/nkKLlkiWwSCMepriBrNgZsEgJhC2dBczMrkfFCxcpJOMOKpnkxM=
X-Received: by 2002:a81:920e:0:b0:31e:7664:fa04 with SMTP id
 j14-20020a81920e000000b0031e7664fa04mr1861840ywg.385.1658338919663; Wed, 20
 Jul 2022 10:41:59 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylama@gmail.com
Sender: gavonkomi32@gmail.com
Received: by 2002:a05:7010:de0a:b0:2e8:7f1a:1f28 with HTTP; Wed, 20 Jul 2022
 10:41:59 -0700 (PDT)
From:   sgtkaylama <sgtkaylama@gmail.com>
Date:   Wed, 20 Jul 2022 17:41:59 +0000
X-Google-Sender-Auth: HSPLTg-FBqDdYLtodapkaaTjLYw
Message-ID: <CA+rrxF1Cc9sHg6cDi91E4oNhnm0c3mAuR4cgiKeiX7-N171vmA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

5L2g5aW977yM5L2g5pS25Yiw5oiR5LmL5YmN55qE5Lik5p2h5raI5oGv5LqG5ZCX77yfDQo=
