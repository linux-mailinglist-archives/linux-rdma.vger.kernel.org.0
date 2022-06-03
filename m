Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E844D53CAF2
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jun 2022 15:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244849AbiFCNxp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jun 2022 09:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242859AbiFCNxo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jun 2022 09:53:44 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFEA3669E
        for <linux-rdma@vger.kernel.org>; Fri,  3 Jun 2022 06:53:41 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id l84so10452478oif.10
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jun 2022 06:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=qw5EyItOxCQDwFpWuJsP6U9apKtAIm0F4oJLWFn2omk=;
        b=Saqd0/mghd2MjOscm7hTvCSspgyDPdYiYAr7evvm3yOSlIdmYs+okZPrxNbrTTPbGO
         Ze3puFmHjX9d6/zQo6vdb4QefHX42FDlIzuJh176cr5yIVC0XkXeMtxz4ZDQT+xMxILu
         ZXZr3kBQ/TgFn7LiqD+7MfykbATtHvCd+YxudhznpL1+QCJLOtg3YMnWTsUgMpkuKetx
         MM3+7n/3F7+NwL+ZHffM4k8ZZCimd20Poeq23a1pTUp13yuc0DuiubE0EiQXntP86HtR
         H+i0vWZFz9Nzxlv+dS/QUPvzRbfK23iBH5mTDVOTRYsJxMs7rz2H+a3CVfx5Gh7Rl5gH
         0+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=qw5EyItOxCQDwFpWuJsP6U9apKtAIm0F4oJLWFn2omk=;
        b=yxUJwowvx9DIEVhB1vqyXZQhf2PKyUpLj4leRrPJo4qnbunw+ViO+f41O+/4Y+HwWe
         CgoWXDhuAWke7JHwVEZmQzDCFkpdTz1hy6YKi9uop0u7XFKpVf54ZUFALhYrqGuxpGv1
         XBBlBJIyZm/RWF+9nyhqIpRKQ91QUFhtjbfCpQbSj3hu+QFNSRTKkawPOy0fJmjggssv
         ubLVBEJUuqz4ieChZx2OSuK01q0NgA59H8grCt+uqcKyQAR0jq4qfVZMtSTa6Ba3+0nv
         wL0k/yvTSyeTRd1Mn56SmvB95dNAdhc77m+ywlrhijLawern+GBOEqNxeIIuGDA+HF8K
         Idfw==
X-Gm-Message-State: AOAM531mSrjacibLLK2PkpRnV3ns20xs13tjiLW1XgGJ60AWu9Q4zlUf
        rwR0Kfx0apISIaUVLLSe7nQ=
X-Google-Smtp-Source: ABdhPJz9NAFeGuECgWuCpzQag3rxVAd6dCU39cA6yLa5Iik3HL5l7NOKSBwt1WlngBgn7drYThFIDQ==
X-Received: by 2002:a05:6808:1644:b0:2ef:b05:1cdc with SMTP id az4-20020a056808164400b002ef0b051cdcmr5468043oib.66.1654264421269;
        Fri, 03 Jun 2022 06:53:41 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:eaea:684b:a746:e718? (2603-8081-140c-1a00-eaea-684b-a746-e718.res6.spectrum.com. [2603:8081:140c:1a00:eaea:684b:a746:e718])
        by smtp.gmail.com with ESMTPSA id a7-20020a056870618700b000f1b1ff7b8bsm3418440oah.51.2022.06.03.06.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 06:53:41 -0700 (PDT)
Message-ID: <84aaf934-9cac-30ae-0fa5-1e40819a519e@gmail.com>
Date:   Fri, 3 Jun 2022 08:53:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Hack, Jenny (Ft. Collins)" <jhack@hpe.com>,
        Frank Zago <frank.zago@hpe.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: [bug report] RDMA/rxe: Incorrect behavior for atomic retries
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

Testing the current rxe driver with a patch to drop packets at random when running
the pyverbs test suite shows that the driver successfully recovers from dropped
atomic request packets but does not recover from dropped atomic ack packets.

A review of the code shows two problems. First the second argument to rxe_xmit_packet()
is the packet info struct from the request packet and not the saved response packet.
Second saving a pointer to the skb in qp->resp.resources[] will not actually work since the
skb is freed by the network stack after the NIC sends it. It would be better to save the
return value in the atomic ack header and rebuild the skb each time from this saved value.
This can be seen from the fact that the returned skb from a retry has incorrect data in it.

Bob
