Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9681F708B56
	for <lists+linux-rdma@lfdr.de>; Fri, 19 May 2023 00:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjERWNj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 May 2023 18:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjERWNi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 May 2023 18:13:38 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCF5121
        for <linux-rdma@vger.kernel.org>; Thu, 18 May 2023 15:13:37 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94a342f4c8eso33689266b.0
        for <linux-rdma@vger.kernel.org>; Thu, 18 May 2023 15:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684448016; x=1687040016;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=BHT6TY278pRhfBUik6KKru53hmzVS5d82aLDwwjLDIQy9LKGFyuygEoS4dLNyN7Xzl
         8WCMELQhgZQ/85Srl/3JbgySzpg8wFhA7lk5Qf7vHTy9AKV6/Er20njLTAOzuFbHpYnO
         mJeayajr6UWnoU2qcpB/hZ1FZu2/h9qMRpM7LHwIRg3msxS7EMZW/sONFIxblIHIXl+g
         gdFvwdFvoJq7K8Blt7HPtuOFup6FmvLx7+Xgowgdk8toGGE/lPe2uhyN/R+EpAzZrL0L
         cpvtYqdkwsxDZmRAdzszKk/1RG/apu6h6DyTulSc6ScnWXHFeXEJjLxt1Nrgsl2BFvP9
         /cuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684448016; x=1687040016;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=TgPykLVsUAqzvaqZwlEULxe/RIPjR0HMbaqEHzyCD5P7h2jIZv4MATLU2SZOga69M6
         W73gByKQ+dbRJ1sFcm0GMGtZ6mHrfKB9zlIZ6PsVG/nXb0jg+vDgXwcJ4ooOikOr5Jzv
         pfmeknhg3T29hacqsDSQGIY1o4Zku6E3i3Nn+XST3Ki0byfJDEE/EB6rCjw09DwDiAqf
         YDkEiHhTBTLJUiD6SR1aPO3YvC4miOkWp442G2ev6Brg7V385NoIAV4FRy/L0vBNUGxy
         AA6Bn8hXU+en5GQm8y6dytMFOfrRaQU3FDnGiIzoPBUBVMTn4tj/I2KHVXUVpOgVGcMn
         LsDA==
X-Gm-Message-State: AC+VfDzPiJILPMBMWENLiFoq0K2WSRB3JDZb6K0+VJtjdVdn0zuFuppO
        El6a8Ja2TsNuq05UaKGZU0CD/JNHbFy9IRd04Og=
X-Google-Smtp-Source: ACHHUZ6gB1atgQB/XB6bE3dQjC9gp0f366JtRKRrDRFu7LYh9ZcrnN3Z8/lCkBlgJaijC6ioCTFLkRxscdnEI/LANMY=
X-Received: by 2002:a17:906:7495:b0:96f:56ab:c69b with SMTP id
 e21-20020a170906749500b0096f56abc69bmr520724ejl.3.1684448015517; Thu, 18 May
 2023 15:13:35 -0700 (PDT)
MIME-Version: 1.0
Sender: mrsmayaoliver483@gmail.com
Received: by 2002:a17:907:368e:b0:957:2d5f:3d8f with HTTP; Thu, 18 May 2023
 15:13:34 -0700 (PDT)
From:   Dr Lisa Williams <lw4666555@gmail.com>
Date:   Thu, 18 May 2023 15:13:34 -0700
X-Google-Sender-Auth: 2R4mTzq8unp_d2_r2QFV7brIfNY
Message-ID: <CAAyxa8mZr8d6FBMeM-W7D_0ma0OnWheb6F01nwbqwzg8jtu6VQ@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

My name is Dr. Lisa Williams, from the United States, currently living
in the United Kingdom.

I hope you consider my friend request. I will share some of my photos
and more details about me when I get your reply.

With love
Lisa
