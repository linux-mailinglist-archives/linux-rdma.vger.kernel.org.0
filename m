Return-Path: <linux-rdma+bounces-4322-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E2394EA41
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 11:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A391F2230A
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 09:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D32616DEC8;
	Mon, 12 Aug 2024 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D8mMz+Tw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C097216DC03
	for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723456097; cv=none; b=Z+t2CZH0NKS3t3QWochxyiD5E14Sdt1o2slZ88hF0Uz8TgN+zXeilKJNdaROL9l/Q6isxFPpPiV6syDg72rXQ+qbQLPpw+F8g04ighCvz1VHz6YPfUt7gX33Or4opPx8BimN1Q685cEVk6chMa8DPODrnhkO2t8xfV34G/bFLjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723456097; c=relaxed/simple;
	bh=vedQpMXtHOrSK0LVZ7JdQ0SFPeZ4nokZmO7z8ALpMFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImeTWbNITrJpIdpQwb5jtQxt92jUJnW0SXaFBRTGwbaQ4+QgkHGNe2x6T+md65gXIr16MJP83oYySJgZituutVLz+iWdGF+S80p0ND4XU4e/8HKlRgBPGEGD4eqc1h5ExSbxdXqUvbBmqgsRdfPhj4V1FSwC8yqz2RAJbUw75fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D8mMz+Tw; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0608e3f4-2924-4c2b-93c9-e9368bb6e4f0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723456092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+zOyl+iV5XWsIICBRrjNFA4t8yFQxXKBC21Eeyu8HU=;
	b=D8mMz+TwpVV7LO/rcBI45jlmXj7XiAQWgBvTpufssIPGs2dEWzb2Av9tFF6ZGqiZjn6lLV
	/mNv1Wh7ibQdDnN4RxEvdFPTIKehva817NRM39SzgkQ6MwwNwr7PBIIsk4ghWVw3NzprkC
	72FxAWpwrjNo2jNrrKTzF1k1oBAwSWg=
Date: Mon, 12 Aug 2024 17:48:01 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next 13/13] RDMA/rtrs-clt: Remove an extra space
To: Jinpu Wang <jinpu.wang@ionos.com>, Leon Romanovsky <leon@kernel.org>
Cc: Md Haris Iqbal <haris.iqbal@ionos.com>, linux-rdma@vger.kernel.org,
 bvanassche@acm.org, jgg@ziepe.ca,
 Alexei Pastuchov <alexei.pastuchov@ionos.com>,
 Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
References: <20240809131538.944907-1-haris.iqbal@ionos.com>
 <20240809131538.944907-14-haris.iqbal@ionos.com>
 <20240811084325.GD5925@unreal>
 <CAMGffEk1iuHiDOF5CmPyCXb+_gJWea2hJT7sV05mf27+JftpyA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CAMGffEk1iuHiDOF5CmPyCXb+_gJWea2hJT7sV05mf27+JftpyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/8/12 12:10, Jinpu Wang 写道:
> On Sun, Aug 11, 2024 at 10:43 AM Leon Romanovsky <leon@kernel.org> wrote:
>>
>> On Fri, Aug 09, 2024 at 03:15:38PM +0200, Md Haris Iqbal wrote:
>>> From: Jack Wang <jinpu.wang@ionos.com>
>>>
>>
>> No empty commit message, please provide a proper description.
> This is really simple change, the subject should explain it clear, but
> ok, I will extend it also in the commit message.

For your reference, Adding "No functional changes" in commit log should 
be OK. ^_^

Zhu Yanjun

>>
>> Thanks
> Thx & Regards
>>
>>
>>> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
>>> Signed-off-by: Alexei Pastuchov <alexei.pastuchov@ionos.com>
>>> Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
>>> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
>>> ---
>>>   drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
>>> index fb548d6a0aae..71387811b281 100644
>>> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
>>> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
>>> @@ -1208,7 +1208,7 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
>>>                ret = rtrs_map_sg_fr(req, count);
>>>                if (ret < 0) {
>>>                        rtrs_err_rl(s,
>>> -                                  "Read request failed, failed to map  fast reg. data, err: %d\n",
>>> +                                  "Read request failed, failed to map fast reg. data, err: %d\n",
>>>                                     ret);
>>>                        ib_dma_unmap_sg(dev->ib_dev, req->sglist, req->sg_cnt,
>>>                                        req->dir);
>>> --
>>> 2.25.1
>>>


