Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10196596E03
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Aug 2022 14:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbiHQMCN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Aug 2022 08:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbiHQMCM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Aug 2022 08:02:12 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E45844DA
        for <linux-rdma@vger.kernel.org>; Wed, 17 Aug 2022 05:02:12 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s199so15151186oie.3
        for <linux-rdma@vger.kernel.org>; Wed, 17 Aug 2022 05:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=pbCVlee58SNRljTVR7wTvz7D3A0MvcLCtUjVncuzsEg=;
        b=UXnkFigrWNgGKaOx0VQnd77QtAXH8MEBszhAV9Mmh/2E5RB+qCgtKhuL8L7XiRV5S0
         Lqw0nPiwxOQHCnXkR5J7fJV2eJOsJNGxDAHKNaxRpLBMVPOr/ld336SPTjjFRGW8M2S6
         p6NylbgEfNhN+akEX/D1mFH0i2aHG9Xw2qMU+TNZ+5GQE5OyJXnFYL3XIFNp6ETxkEi8
         zJYrQr+OW5NTx0Q0qZolMm3nLwXr0CnCWm29w3/4IhAoZ+kHQRc7DnPr0t/WFSa+GeJJ
         rJXIgOSE0nET6YA6K+Jy7hQbtGvtI9OjCd/M7rmX25jhWRWQRb/NyIM9o1Xv92y3XHEX
         LNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=pbCVlee58SNRljTVR7wTvz7D3A0MvcLCtUjVncuzsEg=;
        b=zXbByDhOdfBZ5hOR1JooeWYekd6AAFub9qhTFpV+htZ00Jsf9D2QD7flUZSBaLd7y5
         gVs80LR97iKqga0HZw+WeXu3tMyoeXMukaouGpP2oa6NYd55NzIFnp4OgCcLaDXPDPbm
         ZDieYFBfCz1jve6tnM8bclNvUS+fr/t/jPjzZKoGe7ASn9CTXEMj535/23epuVFVcikG
         BHEulIarUPzRioOTgTMi+tT+k8Whj0CM0y3SyHM1b9z6WXbM7y922BBlat+d9XL4mh9P
         82O/eLs9vEY5avyYRFtmeFO34pOT8u5CpXLq0XD46cVPz8jv4+Pr20bOP2fnODvxiBs5
         iAHA==
X-Gm-Message-State: ACgBeo2DJ4tjlxzza8mALd3ioPzSuC7iVXxBLzjN78lRQQeiJkdayORB
        0RRaiFx/uEVmWLXoOZasbmRFhaTaG7KMlGROS1k=
X-Google-Smtp-Source: AA6agR4NSnF9F3v7ocNS/RdoIxQ0eH5h6/pJ5RK5y3AH1+GM1ulDwxnyGrJvl2h/tb00JyHTMNLXH4t97BW7sJhsiFg=
X-Received: by 2002:a05:6808:124c:b0:342:9c9e:c935 with SMTP id
 o12-20020a056808124c00b003429c9ec935mr1363528oiv.70.1660737731350; Wed, 17
 Aug 2022 05:02:11 -0700 (PDT)
MIME-Version: 1.0
Sender: rw713667@gmail.com
Received: by 2002:a4a:ae4a:0:0:0:0:0 with HTTP; Wed, 17 Aug 2022 05:02:10
 -0700 (PDT)
From:   Charles Anthony <barcharlesanthonylawfirm1@gmail.com>
Date:   Wed, 17 Aug 2022 12:02:10 +0000
X-Google-Sender-Auth: QGuHA57Da4EWk8xAfjcMlStDAW0
Message-ID: <CAAVzffGMtbLMTw+JQKJYRvxkigDqzZNnaCh_fepErtaxeDqDsA@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-- 
Hello

My Dear, I am Barrister Charles Anthony, I am contacting you to assist
retrieve his huge deposit Mr. Alexander left in the bank $10.5
million, before its get confiscated by the bank. please get back to me
for more details.

Barrister. Charles Anthony
