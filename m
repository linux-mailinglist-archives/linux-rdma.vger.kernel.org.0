Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D258580455
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Jul 2022 21:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiGYTPK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Jul 2022 15:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbiGYTPI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Jul 2022 15:15:08 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C48BCAA
        for <linux-rdma@vger.kernel.org>; Mon, 25 Jul 2022 12:15:05 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-10cf9f5b500so16002170fac.2
        for <linux-rdma@vger.kernel.org>; Mon, 25 Jul 2022 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FoZ+OyiaWFxLGZHK7Yi02xiZwpx29E9syKQ74Y9Ln2A=;
        b=q2dcksCNRoW3b29xRMobFkW+2Vo55cPh6RFTosB0w8bEbKsBtWHKSysEWIh8euE9qa
         g2lBP3A644kP3+EuM0JgnG9I8TU732fX1MK0+PBhNz09KN4luVWxMYvL+7iqtz2aah7G
         ziGBys1/Lz4zJ0ThmesUv2IYAGNdsowS//sgNyHbzxf/nrJTjOXy4moyp8wdCh7Jjl9K
         qtwYrLUyVZSEfmcPqE7+B5FVMB16+2FgACUzWPXvBwIZJCMnCk6Q13GK9eEgt1GO7duK
         M0HbX+bG8B2JFl0QL41n9pswSmKI7TbE1mX86q4IFE+mfQBaZBsm2mlozmmSsc2IgPJf
         M7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FoZ+OyiaWFxLGZHK7Yi02xiZwpx29E9syKQ74Y9Ln2A=;
        b=gxndTRTyM97qeZXZte9VMEJ8WJFRuOIj1EFGbZHc8ZOmPnBmTVc1GBKC/Jt7lN+gjs
         hZbwilEef6I+lR1RLqTaPKWvb6VwpXgEiwwVivuKVZn9P4Fb5sbIc2/r6MN+qPqHjxC7
         gQU8Ult2MYY8jBh74xEE2GfWuioM/LCEFU06UUKTcNzusZ3fqBvYZqwbSsQ5aJKRufad
         BM9d0kb9NlHVzMOw7zL8oH6hco7oTrkNtTxWKjfzxEH5GFkxhA5VXF8vrVEQkixfir1H
         rzZeK3YcPt4VcQHL4cVTz2H0fHEZpEfPhg88i4jdKEoVGpzXiThIVAA6pcZ63RApIy5w
         Hwig==
X-Gm-Message-State: AJIora+jlD4fm8Q36Spt7njZ/M4ilqZz7aZ6e1lOEa5a6lM8tppWkYmv
        Gg4ai3T/0UAXcCm9kvq5XQnwbqVZMIQ=
X-Google-Smtp-Source: AGRyM1sq2XMQK6tGIxvLn4EqFO3crmw7plzSunusUiUVMlpkbrvj/AEgy6fbAyIYFFCEpAtG/hxcCA==
X-Received: by 2002:a05:6870:a113:b0:10d:a65f:c518 with SMTP id m19-20020a056870a11300b0010da65fc518mr10019845oae.259.1658776504688;
        Mon, 25 Jul 2022 12:15:04 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:4c89:b904:9d29:3727? (2603-8081-140c-1a00-4c89-b904-9d29-3727.res6.spectrum.com. [2603:8081:140c:1a00:4c89:b904:9d29:3727])
        by smtp.gmail.com with ESMTPSA id 64-20020a9d0f46000000b0061c7e5d270bsm5427722ott.48.2022.07.25.12.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 12:15:04 -0700 (PDT)
Message-ID: <30b8e464-c3dc-47c2-4636-9fd02a2cd6cd@gmail.com>
Date:   Mon, 25 Jul 2022 14:15:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND RFC PATCH for-next] Revert "RDMA/rxe: Create duplicate
 mapping tables for FMRs"
Content-Language: en-US
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Haris Iqbal <haris.iqbal@ionos.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
References: <1658312958-13-1-git-send-email-lizhijian@fujitsu.com>
 <CAJpMwyier2gtHoMhkrFeNXmqjUo9ab2Ba4Ef_YZoCwv__9cz=Q@mail.gmail.com>
 <17df2afa-3c5d-c57d-47ad-640399279965@gmail.com>
 <9f67703e-a030-c467-dfd6-6b4cf0538e7f@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <9f67703e-a030-c467-dfd6-6b4cf0538e7f@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/24/22 23:00, lizhijian@fujitsu.com wrote:
> 
> 
> On 22/07/2022 02:18, Bob Pearson wrote:
>> On 7/20/22 05:50, Haris Iqbal wrote:
>>> On Wed, Jul 20, 2022 at 12:22 PM Li Zhijian <lizhijian@fujitsu.com> wrote:
>>>> Below 2 commits will be reverted:
>>>>       8ff5f5d9d8cf ("RDMA/rxe: Prevent double freeing rxe_map_set()")
>>>>       647bf13ce944 ("RDMA/rxe: Create duplicate mapping tables for FMRs")
>>>>
>>>> The community has a few bug reports which pointed this commit at last.
>>>> Some proposals are raised up in the meantime but all of them have no
>>>> follow-up operation.
>>>>
>>>> The previous commit led the map_set of FMR to be not avaliable any more if
>>>> the MR is registered again after invalidating. Although the mentioned
>>>> patch try to fix a potential race in building/accessing the same table
>>>> for fast memory regions, it broke rnbd etc ULPs. Since the latter could
>>>> be worse, revert this patch.
>>>>
>>>> With previous commit, it's observed that a same MR in rnbd server will
>>>> trigger below code path:
>>> Looks Good. I tested the patch against rdma for-next and it solves the
>>> problem mentioned in the commit.
>>> One small nitpick. It should be rtrs, and not rnbd in the commit message.
>>>
>>> Feel free to add my,
>>>
>>> Tested-by: Md Haris Iqbal <haris.iqbal@ionos.com>
>>>
>> Li,
>>
>> It has been a while since this was added. If I recall there was a problem in rnfs
>> that this was supposed to fix. It was also supposed to allow overlap of using the
>> previous mappings and the driver creating new ones. But it seems that most fmr
>> based ulps don't require it, maybe all. Before we do this we should make sure that
>> blktests, srp, lustre, rnfs, etc all work. Have these been tested?
> 
> blktests(nvme over RXE and srp) works fine after this reverting.
> lustre and rnfs have not tested because I have no lustre and rnfs local environment currently.
> 
> I do wish to know what's the original problem you fixed in 647bf13ce944 ("RDMA/rxe: Create duplicate mapping tables for FMRs")
> Could we have other approaches for it such as add locks to prevent the potential *race*.
> 
> I agreed on the view[1]("you need to go back to one map") from Jason
> 
> [1]: https://lore.kernel.org/all/20220527124240.GB2960187@ziepe.ca/
> 
> Thanks
> ZHijian
> 
>>
>> Bob

Li,

I agree. You can add

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>

Our Lustre testing is still on older versions of the driver with one map and it works fine.
I am not able to reproduce the rnfs results from last year so I just don't know.

I still have failures in srp blktests but I doubt it is related to this issue. Tests 002 and 011
seem to hang and I have never been able to figure out why.

I suspect that mr->state can be racy. It is a state machine that can trigger changes from client code or
tasklet code on the request side or the response side. I don't have solid evidence that this has happened
but it seems to me like a good idea to guard the state machine with a spin lock. I will post a patch that
does that.

Bob
