Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFF652D65B
	for <lists+linux-rdma@lfdr.de>; Thu, 19 May 2022 16:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiESOnn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 May 2022 10:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239945AbiESOnj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 May 2022 10:43:39 -0400
Received: from sender2-op-o12.zoho.com.cn (sender2-op-o12.zoho.com.cn [163.53.93.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA35AE732F
        for <linux-rdma@vger.kernel.org>; Thu, 19 May 2022 07:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1652971379;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:Date:MIME-Version:From:From:Subject:Subject:To:To:Cc:Cc:Message-ID:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=ly4M7Uf/doGJ3WfSJNrVXMUgJUF9+Wxm8ac8tvuqdww=;
        b=c92gu8hqs1z0SjgkD55WQ2DSqGVajX7bQp8NYj7A1gPpP2FyfGpZttScoVpRHlLZ
        TjBvJPxsb3CKatIbV4U8IE0fMNkL8ctj9wdsgx5n+XPWn88h9XQTNptbsk6LVoVJBwU
        wwATYuY7Wx7Pg84aruH+2x7qEiSL5ctxYMHBl85g=
Received: from [10.0.0.7] (113.116.158.155 [113.116.158.155]) by mx.zoho.com.cn
        with SMTPS id 1652971377289340.42075439525024; Thu, 19 May 2022 22:42:57 +0800 (CST)
Date:   Thu, 19 May 2022 22:42:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   Chengguang Xu <cgxu519@mykernel.net>
Subject: Re: [PATCH] RDMA/rxe: goto error handling when detecting invalid
 opcode
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Message-ID: <caafd1d2-eff1-d6f3-a24e-f0c33c3ff69f@mykernel.net>
References: <20220519083049.2259564-1-cgxu519@mykernel.net>
 <4d3e809c-2bc0-6e8a-2f78-726bee10a937@fujitsu.com>
In-Reply-To: <4d3e809c-2bc0-6e8a-2f78-726bee10a937@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

=E5=9C=A8 2022/5/19 17:20, lizhijian@fujitsu.com =E5=86=99=E9=81=93:
> looks it's duplicated with
>
> https://patchwork.kernel.org/project/linux-rdma/patch/20220410113513.2753=
7-1-yangx.jy@fujitsu.com/
>
> and it was already applied.

Ah, it's my fault, please ignore this patch.


Thanks,
Chengguang

