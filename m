Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67381243B8E
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Aug 2020 16:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgHMO3k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Aug 2020 10:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgHMO3k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Aug 2020 10:29:40 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDD4C061757
        for <linux-rdma@vger.kernel.org>; Thu, 13 Aug 2020 07:29:39 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id n128so1357468oif.0
        for <linux-rdma@vger.kernel.org>; Thu, 13 Aug 2020 07:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cwXG/uA9lVKpH3fbGMtCXJlLK2elEDg6aJy3u6+wcl4=;
        b=c2KC8PbodlKn8RgM/s6ap6f5YV+44YAhK3bzKUTzW2JdtGsBlXx92Wr6N3cG9Ox84L
         5Q4Xt5ZA92byxGpSzARftiJGx8Xexi+ILR6hJrbA/XM2y77pvZieXXOWMkNiewZVfzuA
         12M3Iu9wkEZPVvvX1I3VPm2e6Vqo2ffj6NSuIqL5Azjw337jiJI0iGAhGqzLIQQvmt2I
         aXtn/xtTRPI4gjbk/OpKL4vwpP0l+42Bs+wDJJ8AOQ171nW68DHBFr6lDrJ0nGddiLrA
         7+LtBE3yRaZrsh6N+0Bj5Ei40/TgzjyJvNLAcHVaNRPFyRrEdXevLpPDqIAX3tvVfdk/
         kt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cwXG/uA9lVKpH3fbGMtCXJlLK2elEDg6aJy3u6+wcl4=;
        b=BTq6jTtjExV+N53eqET5HLRSWhEuiJJ0aP1vZB4wqGVJ7KJ7jPBf95T6aNczd7HzDu
         HquUPjg2tCDQyFnOOn3i7M7JxuQJbOMyKHNW9TBaSwAKGjjoQ65pBQkl25cvLGSu6S60
         JQ6XeNyMyV+qdgAXmJATByuaHFhNsFLK5pivvXwGLlGJZQnA6ZvHGZgf3zZ6qLdozUGK
         +8achgfFvjYEd4T6BimovTwBaslEeX5cLPJzY/9ZwizK+O250w19XvhkFn+Tbd2tV+21
         ph+8ddpi/cVWHHBAlZ8H7IYGxhoJ8OizTAnKcBOyA4zDvwE74D5XeVybPmPBJ/Ht+KoC
         KvBg==
X-Gm-Message-State: AOAM531j4DvEyYkiahxcAahyKYJ/edefYnR0pHsDOQf1WAdAy6alo5f8
        ay6fZx/Fl2rNMzK5j6W8rhc=
X-Google-Smtp-Source: ABdhPJyZAuHI5Ae6ZKGLebq8GL0JlcgOYCypYl3D4+8IMvLKyLJIo0V/JKKV0MMtxpWGqHbjThCGhA==
X-Received: by 2002:aca:f448:: with SMTP id s69mr3712692oih.4.1597328979458;
        Thu, 13 Aug 2020 07:29:39 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:d46:5113:64d8:597c? ([2605:6000:8b03:f000:d46:5113:64d8:597c])
        by smtp.gmail.com with ESMTPSA id x11sm1210664oot.0.2020.08.13.07.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 07:29:38 -0700 (PDT)
Subject: Re: Is there a simple way to install rdma-core other than making a
 package?
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, jgg@nvidia.com
References: <75bbc81e-cde9-c8ac-0ba3-04bf17b8d5fa@gmail.com>
 <20200812055730.GJ634816@unreal>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <ff6bcd23-62c0-f178-f6a1-22edeecfc926@gmail.com>
Date:   Thu, 13 Aug 2020 09:29:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812055730.GJ634816@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/12/20 12:57 AM, Leon Romanovsky wrote:
> On Tue, Aug 11, 2020 at 10:41:02PM -0500, Bob Pearson wrote:
>> There doesn't seem to be a documented way to make install rdma-core, at least in the README file. However trying the obvious
>>
>> $ bash build.sh
>> $ cd build
>> $ sudo make install
> 
> The build.sh script that comes with rdma-core builds libraries in-place
> and is not suitable for "make install".
> 
> Thanks
> 
Agreed, but the Makefile in the build directory does respond to make install but a little incorrectly. Maybe it's just a tease to drive old farts like me crazy.
