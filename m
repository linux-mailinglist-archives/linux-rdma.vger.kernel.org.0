Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6715BB5D9
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiIQDN5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiIQDN4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:13:56 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FA84D26D
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:13:55 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id t62so8309956oie.10
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=PBP0in/gnZ+ZdWsVm2woRpVWStNhtkInnW+HfSBYproegJZt2kWiaa5IVXjUQt2ISX
         a0kENyOAGMuNBH584DOqOB/CyXm9T77T95YK2/NuQGmN8xcHAy7jhOmk4AW1Cwkf0CH0
         Qw9WxYp/Aw2kn2DE7yHXcIRWHrBWkfUDpnjgmxWqcqxi7v/Tn0CYHJ+Ny+Iy2RAwrIKt
         hZ0ds56pXOElJ6/pzzT02okmPyyhQfC/YMaQNg7xNpVXi+BnD6UddfoxkBdEGyQbu0Wu
         Oh4VBhx3XhWM5OMSGE/34CFAztkioju7E1v6sFlwD+7Ixq5k9DAXhHP26FDlKLRr/k02
         N67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=nLfOHjON26ks7lmle0wLTzM0njAjfPBpdHjmfzeMBzPD05LalHNEczM/kvDSHjcDYB
         SpjaHCB4ZBEyW2WT34F3vt59QU0YjQLR0+Vq8RGYbzyvkrqMZfU8W7DCSewzK6iUPCnN
         lgcom8f8XoLsYipbtSo1rwypqRAGFdEc9heNFbkYAgfgD5Vfe0kAi+fuiWJFqj2Kf7s7
         lCLXFP6CKb7F+jy9cJeDenyMNjNjEApMQifhithZaYXqcs2Kvx72u9o0ySX4jDRdeK6a
         15xQOucjF8FOBSqaid5ZHnL3aEQFoTarBrcaF0NuItUfyhqLC4B0VDCb0PMAaPxZ+XAW
         EqIQ==
X-Gm-Message-State: ACrzQf0AVKiUskA4o6yOibJmm4uOQWhfENQOxcwgCvZV2NW6YFxXVizB
        Oc+btCWwieIsYdUTEnjLSkYaxklY/Uw=
X-Google-Smtp-Source: AMsMyM7H9EUoNUqsSlYi/so9Nto2e0eipGFd/G0PHyMyVD8Q6XDsOT7+610H8QobdgZftVOD2qKaOw==
X-Received: by 2002:a05:6808:1285:b0:344:f3b4:29f2 with SMTP id a5-20020a056808128500b00344f3b429f2mr3769316oiw.187.1663384435278;
        Fri, 16 Sep 2022 20:13:55 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:a0bc:8695:d7dc:8eb9? (2603-8081-140c-1a00-a0bc-8695-d7dc-8eb9.res6.spectrum.com. [2603:8081:140c:1a00:a0bc:8695:d7dc:8eb9])
        by smtp.gmail.com with ESMTPSA id w12-20020a056808090c00b0033e8629b323sm9841493oih.35.2022.09.16.20.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 20:13:54 -0700 (PDT)
Message-ID: <3ac4ba61-a994-fa71-1834-021cd8200336@gmail.com>
Date:   Fri, 16 Sep 2022 22:13:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: some of these got sent twice. They are the same. Just ignore the
 extras.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

