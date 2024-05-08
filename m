Return-Path: <linux-rdma+bounces-2356-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDA68C065F
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 23:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808231C21629
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 21:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DCC13175F;
	Wed,  8 May 2024 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSZzpPqo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75898120C;
	Wed,  8 May 2024 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715204406; cv=none; b=pJGqy5YTw76kO6LT9/7Bfq2RVY0YI1eYdEU04a4p9hKkkHxx5M+G7Eco+Gnum/fmIk47ChkFDclBqvTkFITx5q3krX9krm17e9t5Z5vmpP7iwYo5N+1knANTXwWTwxr8RRB7ZGwDsMPgSNpZ4TwU/NvZY6RrPg0fQJ+eKakAz5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715204406; c=relaxed/simple;
	bh=bzTGae9EOZKFKSew3VcSKUbgakBdZWZDUnv41Y1Gngo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cw8Jvs/UMWSz3DEKZJ9VtZSHhgD68ZpMaJRU+uEiUFCYu3ErAONPFfVxb/0hyD/aw18EaUbNiYpSxq4V5+AkAbeduEGgS1/LpqDNkr09U1xOrFfLTZc515Z1zhvCSbGnaZyVv2nYuWR/bP6kYFyhd2NjxlIn7zy5S9u7LsYsfJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSZzpPqo; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34c8592b8dbso145479f8f.3;
        Wed, 08 May 2024 14:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715204403; x=1715809203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7H9huRivbVATrO/WFy2nNVVcRmMBZKByEpYeYLII4SI=;
        b=XSZzpPqoimJBx5nymUw+E0Pd7dPjRwqhDl/1PScnWP9GkPSbXG/apYPmuiBzdTDDgz
         5rnFmwAw2/Vl2Jbbjw32S5yrsZOx50dtrOaIo/WbcY+0DN2x6bO8b1/xs1dnTt6Vl5Li
         0nxMXF/xJajO6OTzpc4CuyP+L0WkAPqj3Btd37qm58pH0K9LIf1d8iHOs8Ru2jdbQgzO
         kSS4nmmhKf0MUVb+O6eUzLBweI1Ei1Pm12Lmc7scruFf4+ZzfOvS9GDTvUInHi82M0FO
         xFke0LB/ERlYKyzPEeqKqCxaQpMpk7Ej7o9WZKGA5/vfZqlbG4WNrxeWCa4vGu+ojjfV
         5iiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715204403; x=1715809203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7H9huRivbVATrO/WFy2nNVVcRmMBZKByEpYeYLII4SI=;
        b=lB+zTIHES1Gi7+ifDDw+5LUaHAVxSHDl3PJ3GGbgrRNyiT25/nKhsDV7hH/SHxg5uL
         OlfG1Gl6ReRV/BumoVXE566+/RRWP5YpHo9tGEIAYFvXJNDuPxj9cVeaUc9H271hVgoM
         SKkyc15z94jshogKT8zYsVcCtpicyec/FuRDzl66c7uxYiDi/2evUxx6GvDiVXyc8+Es
         d6lFMRNZuCK0AC8I8/d7/6hgVDQywB7TYQ/ODcZtLjS92NiXPZ9VmlBKX8V/f8xbsHyl
         tNRaw2zfmy+eSH8AI5ixI2Vn6yWPO4Suv5k8/BASWYeGQm5GU9wEgH55Jun25qCdWAbX
         L7QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsxxroLYdGJZdZAtu+GOVaGRK97/SoZVlHHCoDspZ09Suiiw0/5ydLuNGZVqsbH/Pnn7jVtbgDdOePtWEt3L1ds6+2xMSu18M5rTpsSfU8RY533BLKpcaEacH1XnBoVhdDZOnjIQqUtELdwsRGcrEBM9odyYP+SUugMrtuOqYxYQ==
X-Gm-Message-State: AOJu0YwchLUTAmyRglab514zMLRkfwkxuRNXUShVAoo3O+YE9yjcMyB7
	kpC/aE3OW7DPN8uwTLVKDbpV4kJzw5GC6HlJDFq/gscvmiF9ZnlA
X-Google-Smtp-Source: AGHT+IEDS631DxOEM4z9Cjs85wfPMT9p4IhcPBKOSJLFJraPYX0iLuE8yst8rmDozGgmppVRjVoVCg==
X-Received: by 2002:a05:6000:b8e:b0:34d:12b4:a4b0 with SMTP id ffacd0b85a97d-34fca80d7bfmr3384321f8f.70.1715204402838;
        Wed, 08 May 2024 14:40:02 -0700 (PDT)
Received: from [172.27.51.192] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f882085c5sm36021675e9.40.2024.05.08.14.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 14:40:02 -0700 (PDT)
Message-ID: <8678e62c-f33b-469c-ac6c-68a060273754@gmail.com>
Date: Thu, 9 May 2024 00:40:01 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
To: Joe Damato <jdamato@fastly.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, saeedm@nvidia.com, gal@nvidia.com,
 nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Leon Romanovsky <leon@kernel.org>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20240503022549.49852-1-jdamato@fastly.com>
 <c3f4f1a4-303d-4d57-ae83-ed52e5a08f69@linux.dev>
 <ZjUwT_1SA9tF952c@LQ3V64L9R2> <20240503145808.4872fbb2@kernel.org>
 <ZjV5BG8JFGRBoKaz@LQ3V64L9R2> <20240503173429.10402325@kernel.org>
 <ZjkbpLRyZ9h0U01_@LQ3V64L9R2>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <ZjkbpLRyZ9h0U01_@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/05/2024 21:04, Joe Damato wrote:
> On Fri, May 03, 2024 at 05:34:29PM -0700, Jakub Kicinski wrote:
>> On Fri, 3 May 2024 16:53:40 -0700 Joe Damato wrote:
>>>> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
>>>> index c7ac4539eafc..f5d9f3ad5b66 100644
>>>> --- a/include/net/netdev_queues.h
>>>> +++ b/include/net/netdev_queues.h
>>>> @@ -59,6 +59,8 @@ struct netdev_queue_stats_tx {
>>>>    * statistics will not generally add up to the total number of events for
>>>>    * the device. The @get_base_stats callback allows filling in the delta
>>>>    * between events for currently live queues and overall device history.
>>>> + * @get_base_stats can also be used to report any miscellaneous packets
>>>> + * transferred outside of the main set of queues used by the networking stack.
>>>>    * When the statistics for the entire device are queried, first @get_base_stats
>>>>    * is issued to collect the delta, and then a series of per-queue callbacks.
>>>>    * Only statistics which are set in @get_base_stats will be reported
>>>>
>>>>
>>>> SG?
>>>
>>> I think that sounds good and makes sense, yea. By that definition, then I
>>> should leave the PTP stats as shown above. If you agree, I'll add that
>>> to the v2.
>>
>> Yup, agreed.
>>
>>> I feel like I should probably wait before sending a v2 with PTP included in
>>> get_base_stats to see if the Mellanox folks have any hints about why rtnl
>>> != queue stats on mlx5?
>>>
>>> What do you think?
>>
>> Very odd, the code doesn't appear to be doing any magic :S Did you try
>> to print what the delta in values is? Does bringing the interface up and
>> down affect the size of it?
> 
> I booted the kernel which includes PTP stats in the base stats as you've
> suggested (as shown in the diff in this thread) and I've brought the
> interface down and back up:
> 
> $ sudo ip link set dev eth0 down
> $ sudo ip link set dev eth0 up
> 
> Re ran the test script, which includes some mild debugging print out I
> added to show the delta for rx-packets (but I think all stats are off):
> 
>    # Exception| Exception: Qstats are lower, fetched later
> 
> key: rx-packets rstat: 1192281902 qstat: 1186755777
> key: rx-packets rstat: 1192281902 qstat: 1186755781
> 
> So qstat is lower by (1192281902 - 1186755781) = 5,526,121
> 
> Not really sure why, but I'll take another look at the code this morning to
> see if I can figure out what's going on.
> 
> I'm clearly doing something wrong or misunderstanding something about the
> accounting that will seem extremely obvious in retrospect.

Hi Joe,

Thanks for your patch.
Apologies for the late response. I was on PTO for some time.

 From first look the patch looks okay. The overall approach seems correct.

The off-channels queues (like PTP) do not exist in default. So they are 
out of the game unless you explicitly enables them.

A possible reason for this difference is the queues included in the sum.
Our stats are persistent across configuration changes, so they doesn't 
reset when number of channels changes for example.

We keep stats entries for al ring indices that ever existed. Our driver 
loops and sums up the stats for all of them, while the stack loops only 
up to the current netdev->real_num_rx_queues.

Can this explain the diff here?

