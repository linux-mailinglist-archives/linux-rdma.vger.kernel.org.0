Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9166C9200
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Mar 2023 03:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCZBJk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Mar 2023 21:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCZBJk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 25 Mar 2023 21:09:40 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEA8BBB1
        for <linux-rdma@vger.kernel.org>; Sat, 25 Mar 2023 18:09:39 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g19so5375557qts.9
        for <linux-rdma@vger.kernel.org>; Sat, 25 Mar 2023 18:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679792978;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oi7mqheHWwWvotxETfaXeotL9pTGJ8sRo9xGGWOooQ8=;
        b=Ehg0mVDDhUTUp9OIMqefQhLw4n4JEUtR1JjSICbFG6kr9PLXMtj51/vQ3Sb4PBvi5y
         YK7khLj6o0DhX1W/7hjomsHOMibdpUqTtGUPgbnH0VnqowMjss8WZTWd6rdZ6op9YlM8
         lDVKyh1T1bss6TZRRPlVosY9QATTJlSdwUGYK7K0acWRUnvrNdGGaRhR3AG3fWpez2Vw
         dHeXQz/f9JX9ZZneoWgL+oYyZTV1lPQh/L7Mquza+SB+sGqsXPtUIJuRxOL7tSFQwEgY
         6ZOTzfzrrC53hRFsgZ9rqMdf2ng6ftpvLiOmsQKda07ig+kmpof86CocmZ7BksUypEwQ
         ttUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679792978;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oi7mqheHWwWvotxETfaXeotL9pTGJ8sRo9xGGWOooQ8=;
        b=OosWWk0bIXRYD0BD6plInAWd+OknZ3BmdluDSBU6m0V7WM3LOzvtfH+3rhKYTNcxrt
         yzFgFKwkpd3Kylk3iCTeZeROfj0IOe93Swt5sLvx/l+7QlomBEgOaFTIjrJDLrckjL/0
         5DZQD1zDFzuuPAUdCoOhdm0O3PbJyTFpb6mYPs2aYlhxdzT2X7JC6f2PvjdCLzvvtakp
         0tputovgk8ycWIv/tkDjJA+oKiJnQx6K+/yNtPa7Xj4hZLbrdk+0Hibn4+J8He9CXYZW
         Ru7ggwrrrTOl0NHb2Zx4cN7P0VyPSpPCiIIeLl9m71SxISDXuxZj6BwFkcM6y9Wfvl9Y
         zpSA==
X-Gm-Message-State: AO0yUKWNXvw9KVkhzQUapyILnmolJXhx2C3t1YB2G7sD4idXgfPQkFHu
        LVhsfO+W8ja4oViibmsJtJ8/f7Uf+ZXdsveIwTE=
X-Google-Smtp-Source: AK7set8CA4tIZlDrR7XIHo07spe4z2fU0QdZwz/MJQ+x8+i1DkzdeIL+55dRRIJKS7aipjHauG4R6sKS+siIRmf+9gU=
X-Received: by 2002:a05:622a:1a24:b0:3d3:f7cf:1d4b with SMTP id
 f36-20020a05622a1a2400b003d3f7cf1d4bmr2805812qtb.2.1679792977823; Sat, 25 Mar
 2023 18:09:37 -0700 (PDT)
MIME-Version: 1.0
Sender: bbchitex1@gmail.com
Received: by 2002:ac8:5c88:0:b0:3e3:8d99:b6ea with HTTP; Sat, 25 Mar 2023
 18:09:37 -0700 (PDT)
From:   "Mr.Patrick Joseph" <mrpatrickj95@gmail.com>
Date:   Sat, 25 Mar 2023 18:09:37 -0700
X-Google-Sender-Auth: jzwT2uQ_Nom6Q4bQ9DbugsAzW_U
Message-ID: <CAFvFkXv8r7Zx3H=gJvHQ3nGs9GTkJBZrAKQEOy-RCDGt0M=hqA@mail.gmail.com>
Subject: Greetings from my side
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Good Day. I know this message might meet you in utmost surprise.
However, it's just my urgent need for a foreign partner that made me
to contact you for this mutually beneficial business when searching
for a good and reliable and trustworthy person. I need your urgent
assistance in transferring the sum of $27.5 million dollars currently
in my branch where I work. If you're interested please reply to me
immediately so I will let you know the next steps to follow.

Thanks.
Mr.Patrick Joseph.
