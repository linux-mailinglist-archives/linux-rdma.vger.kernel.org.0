Return-Path: <linux-rdma+bounces-1761-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE66896EDB
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 14:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6331F2278C
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 12:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F74E146000;
	Wed,  3 Apr 2024 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="A1Rc36K1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp37.i.mail.ru (smtp37.i.mail.ru [95.163.41.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30F41420C4
	for <linux-rdma@vger.kernel.org>; Wed,  3 Apr 2024 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147341; cv=none; b=GYsftpveZTG8Jo0eJB2x31d15bTbTzPEQkBr1sa+bi5T9Un6EBv7XigjaBqvXPmgrIpHAEbSBrz6qOFea1T/wR6w8n4UwIGnqTNPPC6Yna3NMznSklF9j9DQvesPrjndCRnrNR94XPbN0UGcfqU8acIwtE0mBsh/3cjX1q9cODE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147341; c=relaxed/simple;
	bh=Gjh3ov5KAE/LNnGtUgLvzLYFaxCOZqvCCpOidT4SDRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LLJvVNENT9ua1VecYfsGZXz5DlBR3c6cCIV5DBcngr/snmbZ80H85UP48h/1v0HBNxvVME2QyHUbd6pYzv3jsRauF7r9PC4dGZji74kvgSRExs+VEtg/K7FBDG8uy5zKq3hapH/NtgbawgYfoVFkVODvwF63FflMFNwiWvpK130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=A1Rc36K1; arc=none smtp.client-ip=95.163.41.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	Disposition-Notification-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive:X-Cloud-Ids:
	Disposition-Notification-To; bh=zjt2gmHx2hYtkUEfaOK9S8stlKus7SsHgE8iTMwnORk=;
	t=1712147337; x=1712237337; b=A1Rc36K1sMC+sK7JDCgt7NHZHGrjqBtnVSC5dhK2LLwNOHg
	pk+lYzIkBBuE/8qyNAssFKJr+hZJW69oPyB0i0YuF09KzxBms3FWD/591p6lNrnf/V0n66wVPOLzu
	tM5zmtNEz2DDCbIyhCDEl02atOldDr5AUvxS2UObWNiG/PZPuryvWmcTCcoFDfRfAWYc1TIghH2mU
	4MvL2CZxl2Hqzr51UH4xZXVvJuEIqkRmAdb/hi1R616vb/jh3BuVm168J84TWSsoNUbPk+c+kuZlR
	cajEgK01YrlU+vTtQ5F8So2XOASWzKehmijeOhB52ITDE+Y8yvfb30lJSgXbh4OQ==;
Received: by smtp37.i.mail.ru with esmtpa (envelope-from <listdansp@mail.ru>)
	id 1rrzjU-0000000DP3H-1E8b; Wed, 03 Apr 2024 15:28:49 +0300
Message-ID: <5203883b-f83f-b6ff-cfcf-346689f0bfe8@mail.ru>
Date: Wed, 3 Apr 2024 15:28:47 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: mlx5 attr.max_sge checks
Content-Language: ru
To: Leon Romanovsky <leon@kernel.org>
Cc: dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <c78ab477-5b54-82b5-1d5f-8b0022195f78@mail.ru>
 <20231220080729.GB136797@unreal>
 <82ba679e-cef5-bd0b-2084-ae601681cdec@mail.ru>
 <20240317083558.GE12921@unreal>
From: listdansp <listdansp@mail.ru>
Disposition-Notification-To: listdansp <listdansp@mail.ru>
In-Reply-To: <20240317083558.GE12921@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp37.i.mail.ru; auth=pass smtp.auth=listdansp@mail.ru smtp.mailfrom=listdansp@mail.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD96441E77B1D9F2D07B7608C0BC8DC6439BEDBD305538C2AAC182A05F538085040F180E50A00C79973AC8EDD30083ED68EE03039CC8B9DC8FF3C383992C0739EE686091FA637C0ECF9
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7678D195E6F08FCA2EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637BF3E16F0C87855308638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8C015D3AE4D09B13240D6FECD56AFA19B3E769E117D9780B620879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C0F3EFC8F08E14FF8A8941B15DA834481FA18204E546F3947C2FFDA4F57982C5F4F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063783E00425F71A4181389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F7900637F9CAB0A5B52385A6D81D268191BDAD3DBD4B6F7A4D31EC0BE2F48590F00D11D6D81D268191BDAD3D78DA827A17800CE72B69751D2443F04BEC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5278DA827A17800CE754F43A495B1ACFC12EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE75EDB556FFF2B8D41731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5B50E10897C36F97F5002B1117B3ED6962CE44114A2686A89361FAC1196A180DE823CB91A9FED034534781492E4B8EEADF5E532225D4D775BBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFF4A8D94E885A4844B2719EA91891B887F12DCC0478EC96A402571DA58ECEE70D20A397324AFDE1B858CF1FE2B37DBE10FE5338EF972CC4FDFDE45D88FF1B1BDA904EAAF3CA911387C226CC413062362A913E6812662D5F2AF72BBD4AC8FF0C4E5649C4772AD793FE964550E41902C4E4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj/eQ5CRx/6GyYgVhG2U5WVQ==
X-Mailru-Sender: 4CE1109FD677D2770147F6A9E21DCA7BFAFF7BE21511E4E00D8E165B5AC4796C56B7E6645CE5EDD8BB51A8E053822FD5CE8DDCF05647143DC77752E0C033A69E3DC0BC7494A416CF0226C39053983FF0B4A721A3011E896F
X-Mras: Ok

-------- Original Message  --------
Subject: Re: mlx5 attr.max_sge checks
From: Leon Romanovsky <leon@kernel.org>
To: listdansp <listdansp@mail.ru>
Date: 17.03.2024

> On Thu, Mar 14, 2024 at 11:29:49PM +0300, listdansp wrote:
>> -------- Original Message  --------
>> Subject: Re: mlx5 attr.max_sge checks
>> From: Leon Romanovsky <leon@kernel.org>
>> To: listdansp <listdansp@mail.ru>
>> Date: 20.12.2023
>>
>>> On Tue, Dec 19, 2023 at 09:56:01PM +0300, listdansp wrote:
>>>> Hi,
>>>>
>>>> While investigating the one report of the static analyzer (svacer), it was
>>>> discovered that attr.max_sge was not checked for the maximum value in the
>>>> mlx5_ib_create_srq function. However, this check is present in
>>>> https://github.com/linux-rdma/rdma-core. Also, checks are present in most
>>>> other infiniband Linux Kernel drivers. This may lead to incorrect driver
>>>> operation for example
>>>> int mlx5_ib_read_wqe_srq(struct mlx5_ib_srq *srq, int wqe_index, void
>>>> *buffer, size_tbuflen, size_t*bc)
>>>> {
>>>> structib_umem*umem= srq->umem;
>>>> size_twqe_size= 1 << srq->msrq.wqe_shift; // integeroverflowhere
>>>> if(buflen< wqe_size)
>>>> return-EINVAL;
>>>> In my opinion, the only possible solution to this problem may be to add a
>>>> check to mlx5_ib_create_srq similar to
>>>> https://github.com/linux-rdma/rdma-core
>>>> <https://github.com/linux-rdma/rdma-core> like
>>>> u32 max_sge= MLX5_CAP_GEN(dev->mdev, max_wqe_sz_rq) /
>>>> sizeof(structmlx5_wqe_data_seg);
>>>> if (attr->attr.max_sge > max_sge) {
>>>> mlx5_ib_dbg
>>>> <https://elixir.bootlin.com/linux/v5.10.169/C/ident/mlx5_ib_dbg>(dev,
>>>> "max_sge%d, cap %d\n", init_attr
>>>> <https://elixir.bootlin.com/linux/v5.10.169/C/ident/init_attr>->attr.max_
>>>> <https://elixir.bootlin.com/linux/v5.10.169/C/ident/max_wr>sge, max_sge);
>>>> return -EINVAL <https://elixir.bootlin.com/linux/v5.10.169/C/ident/EINVAL>;
>>>> }
>>>>
>>>> I would appreciate your suggestions and comments.
>>>
>>> Can you please provide an example of such values?
>>>
>>> At least in the presented case, the values are supplied by FW and are
>>> supposed to be right without any overflows.
>>>
>>> Thanks
>>>
>>>>
>>>> Best regards,
>>>> Danila
>>>>
>>>>
>>
>> Hi,
>>
>> In the mlx5_ib_create_srq function, the variable srq->msrq.wqe_shift =
>> ilog2(desc_size).
>> Value of  desc_size is result of desc_size = sizeof(struct
>> mlx5_wqe_srq_next_seg) + srq->msrq.max_gs * sizeof(struct
>> mlx5_wqe_data_seg);.
>> The init_attr->attr.max_sge parameter can be set to any 4-byte unsigned
>> number.
>> There is overflow checking
>> if (desc_size == 0 || srq->msrq.max_gs > desc_size)
>> return -EINVAL;
>> but it works correctly only for 32-bit platforms because size_t desc_size;
>> and for 64 bits platforms sizeof(size_t) is 8.
>> So, result of srq->msrq.wqe_shift = ilog2(desc_size) may be greater than 31
>> and will cause overflow in size_t wqe_size = 1 << srq->msrq.wqe_shift;
> 
> Let me repeat my question.
> Can you please provide an example of such values?

Hi,

I have not any HCA and can’t reproduce this case on practice but in my estimation, any user space  call such as

struct ibv_pd *pd;
struct ibv_srq *srq;
struct ibv_srq_init_attr srq_init_attr;
srq_init_attr.attr.max_wr  = 1;
srq_init_attr.attr.max_sge = 0x0FFFFFFF; // any value greater than 0x0FFFFFFE will cause overflow
srq = ibv_create_srq(pd, &srq_init_attr);

will cause overflow on 64 bits platforms.

Best regards,
Danila
> 
> Thanks
> 
>>
>> Best regards,
>> Danila
>>




