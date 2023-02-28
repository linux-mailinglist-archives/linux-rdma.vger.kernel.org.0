Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92AD6A5D0B
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Feb 2023 17:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjB1QZV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Feb 2023 11:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjB1QZN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Feb 2023 11:25:13 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1492ED5A
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 08:25:05 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id z10so5996567pgr.8
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 08:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1677601505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+fERSfhCwXo4Ex3TEn8k7hJWF1bL6uvNF6EVmO00E8=;
        b=aARHvIepBxuQIKhGjTPssPZUetIbmmVhmtZLRCV9WG4LWv512AK68pSLEDl7d9ZBJI
         jeT6aSd6NoqUiBqvyjFDqY4Niogt8n2PZ0aaYQcYlIgK8gpTK1KAHBT/39UC7uY8oDva
         J4DZvInFjCsL0QfLiqR4u3k4hUjDP5G74tN4hcRRQ6jxvmrnzyS370YZFNB5DtEiaIB2
         TP/reqdR+N36XBvC0xd53Xw3fYguTn+nWWWXyzCBDEtPoV0zMRHYiSjp9zxgz/tlqtXv
         wMUpapdM2hwA3jG1uv2950tfEOswygXNV6qg67oEGPDktwZ5AqlQeXd87C2a6XIiYzRZ
         jhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677601505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+fERSfhCwXo4Ex3TEn8k7hJWF1bL6uvNF6EVmO00E8=;
        b=eCbkcE43IiO8WxLECirba2wuX2/XO8uhvBkhM6o6JvZcjGF2NIV0dZhjZLeKtkFABD
         gEHXIsgH3taX+gj0Uy25f8LIOkNkfEH4N6BAk5XEvZ955DGeSYwY0A0aFaanjqSdjxLl
         b8mNvFyd216ehoTnHzchh5e1JQ6o7fpl5h7+SERdWNgSnDhePgdRQCI+wkKXAB9WBOcY
         JgvcMHM2otTf1+MYzX9OmXlO/E5igsvYbJjUGiO798CTkAHDdS+KSPeQIPgwsJVMRr/O
         e315wzWcqu8ao4b2mUnNMyEGowN0cciodFaPBZUpRTBB2CGYSz/TU7sUCGvpudi6LTnc
         3X1A==
X-Gm-Message-State: AO0yUKXr+VhWAo8Wl6QxT/1F+sW98kgI8jVzybdVAw8OfNtfEJGLKNY/
        yA1LExw8Fy8LVrSwN3kzxcPzkFkjQn/kNXlkOH/E
X-Google-Smtp-Source: AK7set83QsN7UWJgdqrF+1F5+JpRedzhw7A27UFW2nkLkaeL4CfC6rZUDaDc7wmUItsfyt9Xkz6xmj3TzD6cEWg9os8=
X-Received: by 2002:a65:6d99:0:b0:502:f20a:6e0a with SMTP id
 bc25-20020a656d99000000b00502f20a6e0amr1418637pgb.0.1677601504819; Tue, 28
 Feb 2023 08:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20230228080630.52370-1-guozihua@huawei.com>
In-Reply-To: <20230228080630.52370-1-guozihua@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 28 Feb 2023 11:25:03 -0500
Message-ID: <CAHC9VhR1UxGQnsWU1bhG1_XMVfdt_j-cVZkKnQ+rjzqcEP_NHw@mail.gmail.com>
Subject: Re: [PATCH 4.19 v3 0/6] Backport handling -ESTALE policy update
 failure to 4.19
To:     GUO Zihua <guozihua@huawei.com>
Cc:     zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        linux-rdma@vger.kernel.org, dledford@redhat.com, jgg@ziepe.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 28, 2023 at 3:09=E2=80=AFAM GUO Zihua <guozihua@huawei.com> wro=
te:
>
> This series backports patches in order to resolve the issue discussed her=
e:
> https://lore.kernel.org/selinux/389334fe-6e12-96b2-6ce9-9f0e8fcb85bf@huaw=
ei.com/
>
> This required backporting the non-blocking LSM policy update mechanism
> prerequisite patches. As well as bugfixes that follows:
>
> c66f67414c1f ("IB/core: Don't register each MAD agent for LSM notifier")
> 42df744c4166 ("LSM: switch to blocking policy update notifiers")
> b16942455193 ("ima: use the lsm policy update notifier")
> 483ec26eed42 ("ima: ima/lsm policy rule loading logic bug fixes")
> e144d6b26541 ("ima: Evaluate error in init_ima()")
> c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule_match()")
>
> c66f67414c1f ("IB/core: Don't register each MAD agent for LSM notifier")
> is merged as the prerequisite of 42df744c4166 ("LSM: switch to blocking
> policy update notifiers"). e144d6b26541 ("ima: Evaluate error in
> init_ima()"), 483ec26eed42 ("ima: ima/lsm policy rule loading logic bug
> fixes") and 9ff8a616dfab ("ima: Have the LSM free its audit rule") are
> merged as a follow up bugfix for b16942455193 ("ima: use the lsm policy
> update notifier").
>
> I've tested the patches against said issue and can confirm that the
> issue is fixed.
>
> Link to the original maillist discussion:
> https://lore.kernel.org/all/389334fe-6e12-96b2-6ce9-9f0e8fcb85bf@huawei.c=
om/
>
> Change log:
>   v2: Fixed build issue and backport bugfix commits for backported
> patches.

Is there a quick summary of the changes in v3 of this patchset?

--=20
paul-moore.com
