Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2506DF248
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Apr 2023 12:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDLKzm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Apr 2023 06:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDLKzi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Apr 2023 06:55:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5315365B0
        for <linux-rdma@vger.kernel.org>; Wed, 12 Apr 2023 03:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681296889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9alFis21lp3H1PeQGiwFBeiCWEcrStDft1SvCWrv9fk=;
        b=FQT6jJGu3OYTx1455515yVvDwRtzkD0nmiVHVDt3/PA9u4tf9gSjMbeFKHXmDhBdNpx+R8
        dAaBXRd80u7yj8mx0ar/l/Gnsi0STW1FaULk4Oexu7TvXuRcuQQuIHqG+Jizwsry0vViZj
        KSyqPsth4mgQTwblZByG2pYgqAlJu2o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-JCGdLZ96NyGdhsF7HHFehA-1; Wed, 12 Apr 2023 06:54:48 -0400
X-MC-Unique: JCGdLZ96NyGdhsF7HHFehA-1
Received: by mail-ed1-f69.google.com with SMTP id z34-20020a509e25000000b00504ed11e0c5so1151997ede.1
        for <linux-rdma@vger.kernel.org>; Wed, 12 Apr 2023 03:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681296887; x=1683888887;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9alFis21lp3H1PeQGiwFBeiCWEcrStDft1SvCWrv9fk=;
        b=mUO9KTgsmZmBKypzZm1gzb5kz+ZidPts08DXqzqsr93UQhSW9xHg6C1CIQFWynm3S5
         TJuIDvY2GWGy3z6f6o23+B0JLl6w9FCvJmyxDc9u2nNoCZzFPwSQIlKkhvu4oZttHi2j
         AcAonwrOaXDdMP4S2tD9qfd/aiSkkv7/L7Wo7XP2Dx0PPnAhRWgkZzGaiz1Cp7u7KUGS
         M4cwDdCU/9QBv0xynmelLq7Str/NCHgiXMdzUQpX1pm9zpUsoV/KBQSJYw3svkdIHe/0
         H31XiTsmEuFjrKZ+HKD2KSw/B/g+3JWSXa3F41PvX+6KikRIRoeTslcKwq1u8lbPzgP/
         xYLQ==
X-Gm-Message-State: AAQBX9cyD6dbT+DcdRf1VOwTHWvS8XKKmSRchbGJ8mmg8NlPFN1VP4Sr
        IBMYqflS+XrckYCkr/pEdCZG76eEiPvIr5lqDxLwIwqX9VcJD9BgTgLIkS1SIFjU7emLU87hyjC
        QKMGZbqcI3Ki/5FOZbB/31Q==
X-Received: by 2002:a17:906:6d16:b0:948:c047:467d with SMTP id m22-20020a1709066d1600b00948c047467dmr5713210ejr.23.1681296887177;
        Wed, 12 Apr 2023 03:54:47 -0700 (PDT)
X-Google-Smtp-Source: AKy350bMaqa5uHrrM7B5IePYN1OMBi6DPhLMgrCl1TykvEZOYX14RUF+y2TD0HStIwcvwi/F7K0XRg==
X-Received: by 2002:a17:906:6d16:b0:948:c047:467d with SMTP id m22-20020a1709066d1600b00948c047467dmr5713173ejr.23.1681296886799;
        Wed, 12 Apr 2023 03:54:46 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id g19-20020a1709065d1300b00928e0ea53e5sm7083290ejt.84.2023.04.12.03.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 03:54:46 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <402a3c73-d26d-3619-d69a-c90eb3f0e9ee@redhat.com>
Date:   Wed, 12 Apr 2023 12:54:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, bpf@vger.kernel.org,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        alexandr.lobakin@intel.com, larysa.zaremba@intel.com,
        xdp-hints@xdp-project.net, anthony.l.nguyen@intel.com,
        yoong.siang.song@intel.com, boon.leong.ong@intel.com,
        intel-wired-lan@lists.osuosl.org, pabeni@redhat.com,
        jesse.brandeburg@intel.com, kuba@kernel.org, edumazet@google.com,
        john.fastabend@gmail.com, hawk@kernel.org, davem@davemloft.net,
        tariqt@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH bpf V7 1/7] selftests/bpf: xdp_hw_metadata default disable
 bpf_printk
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
References: <168098183268.96582.7852359418481981062.stgit@firesoul>
 <168098188134.96582.7870014252568928901.stgit@firesoul>
 <CAKH8qBu2ieR+puSkF30-df3YikOvDZErxc2qjjVXPPAvCecihA@mail.gmail.com>
In-Reply-To: <CAKH8qBu2ieR+puSkF30-df3YikOvDZErxc2qjjVXPPAvCecihA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 12/04/2023 00.42, Stanislav Fomichev wrote:
> On Sat, Apr 8, 2023 at 12:24 PM Jesper Dangaard Brouer
> <brouer@redhat.com> wrote:
>>
>> The tool xdp_hw_metadata can be used by driver developers
>> implementing XDP-hints kfuncs.  The tool transfers the
>> XDP-hints via metadata information to an AF_XDP userspace
>> process. When everything works the bpf_printk calls are
>> unncesssary.  Thus, disable bpf_printk by default, but
>> make it easy to reenable for driver developers to use
>> when debugging their driver implementation.
>>
>> This also converts bpf_printk "forwarding UDP:9091 to AF_XDP"
>> into a code comment.  The bpf_printk's that are important
>> to the driver developers is when bpf_xdp_adjust_meta fails.
>> The likely mistake from driver developers is expected to
>> be that they didn't implement XDP metadata adjust support.
>>
>> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
>> ---
>>   .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |   16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
>> index 4c55b4d79d3d..980eb60d8e5b 100644
>> --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
>> +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
>> @@ -5,6 +5,19 @@
>>   #include <bpf/bpf_helpers.h>
>>   #include <bpf/bpf_endian.h>
>>
>> +/* Per default below bpf_printk() calls are disabled.  Can be
>> + * reenabled manually for convenience by XDP-hints driver developer,
>> + * when troublshooting the drivers kfuncs implementation details.
>> + *
>> + * Remember BPF-prog bpf_printk info output can be access via:
>> + *  /sys/kernel/debug/tracing/trace_pipe
>> + */
>> +//#define DEBUG        1
>> +#ifndef DEBUG
>> +#undef  bpf_printk
>> +#define bpf_printk(fmt, ...) ({})
>> +#endif
> 
> Are you planning to eventually do somethike similar to what I've
> mentioned in [0]? If not, should I try to send a patch?

See next patch:
  - [PATCH bpf V7 2/7] selftests/bpf: Add counters to xdp_hw_metadata

where I add these counters :-)

> 
> 0: https://lore.kernel.org/netdev/CAKH8qBupRYEg+SPMTMb4h532GESG7P1QdaFJ-+zrbARVN9xrdA@mail.gmail.com/
> 

