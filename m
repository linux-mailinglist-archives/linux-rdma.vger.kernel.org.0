Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C5957DF90
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jul 2022 12:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiGVKN2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jul 2022 06:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbiGVKN1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jul 2022 06:13:27 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B593774E02
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jul 2022 03:13:26 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bp17so6938472lfb.3
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jul 2022 03:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+au76xaNYyhUSXsiFXhyKrIrKH5fc7J9/dv/xIH4po=;
        b=ShjnhTdigGD7utEW6bieSt94lWd9PnlAJcHfpe2MDQg8o5BeXUv0KjeXufokxjjCio
         uvbzTvJu6N/bzXmOhpHF3zysJIQtDl3cqnLDqego/xjxmPOPR6G5WxkMq+xqGgaDukm0
         wBjxpFAqGkcGUnV84lNY5jNRApkwBJqiGWIiuAsecxGRThA2dLR62TsCxzfBpqdKrI3G
         BAFamZbsTW+cD+O6O/Iovea3yWFIhU3PCqeysF3Tk0FOEZLT9VGWPZSqcSXqus6SiNO1
         vuYEvxprLcfcFECcANX+me+Zs/zdEOQ0HzIZ/paIrfI7A0n1KYcmj5IerOWI2rFjun/h
         000Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+au76xaNYyhUSXsiFXhyKrIrKH5fc7J9/dv/xIH4po=;
        b=LMIznGPdutWr+UAGeGVbtTTWbk4ENxZ1afaJzpxc8ibeHCjvyXV5kZjnwoORMsa5P4
         nE2WAXBWtbJ8shrcYEu2OBruvgXrONZdF29yeOKXe8mcHdjHZxR9pDHkfKsEASyLvQHF
         nuT354jCS4NqN5bpfwOBh3in5KzQGjZ33JzJkn2cnkw2Ai0O2c9ORE5jR2zik9q4ebxN
         yjKai/bygs7wNfjhNJqITaRoIzPOrXzH+9/ybtuQzabv+3/jg/5suzxea7ZrOavJxIYf
         OC5zETgwF9P8kxbyidHbIN93tQ30ZHHb6urAoXlfp7fCqSUP8zfBX+d9qLPDV2xSaYBJ
         pMvw==
X-Gm-Message-State: AJIora/bZmY5ZstlwQffn6mM4h4xMo/hrk1sAWyZa6W8+IekHdETS+hX
        EMY91WMBeq1Ta1LXnvlEkz/84GL4wsJNOr4KAScZoXiXmRg=
X-Google-Smtp-Source: AGRyM1sR/mvYncngFbJHuTXN0xZJygB39Ikcl8iGpxXKf8V9wg87+Z1AHhyHNJgUTgXDU2pnWNIDB3CHyLNCCkNCw9A=
X-Received: by 2002:a05:6512:acb:b0:48a:4a42:a19 with SMTP id
 n11-20020a0565120acb00b0048a4a420a19mr1109523lfu.690.1658484805099; Fri, 22
 Jul 2022 03:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220721233453.57693-1-rpearsonhpe@gmail.com> <fcb17805-59f8-ec28-f386-92600bc692ab@gmail.com>
In-Reply-To: <fcb17805-59f8-ec28-f386-92600bc692ab@gmail.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Fri, 22 Jul 2022 12:13:14 +0200
Message-ID: <CAJpMwyhS4_Le=n4+MGHdR1rsEFs-EiyjC0sx7VJj_Gr=XgHNow@mail.gmail.com>
Subject: Re: [PATCH RFC] RDMA/rxe: Allow re-registration of FMRs
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     lizhijian@fujitsu.com, jgg@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 22, 2022 at 1:39 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 7/21/22 18:34, Bob Pearson wrote:
> > This patch allows the rxe driver to re-register an FMR
> > with or without remapping the mr. It adds
> > a state variable that shows if the mr has been remapped
> > and then only swaps the map sets if the mr has been
> > remapped.

Hi Bob,

This patch is not applying to any of the rdma branches.


> >
>
> This is an alternative that does not require getting rid of dual map sets.
> The current code assumes that map_mr_sg is always called between calls to reg_mr and invalidate_mr.
> This implements a state machine that marks the mr when it has been remapped and only in that case
> swaps the map sets. Otherwise it could never perform the sequence you want for rtrs.
>
> Bob
