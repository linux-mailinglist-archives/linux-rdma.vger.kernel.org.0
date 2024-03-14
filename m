Return-Path: <linux-rdma+bounces-1444-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E82487C44B
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Mar 2024 21:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BF0282D0F
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Mar 2024 20:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A221A73527;
	Thu, 14 Mar 2024 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="c1CpvgGp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp55.i.mail.ru (smtp55.i.mail.ru [95.163.41.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95B976030
	for <linux-rdma@vger.kernel.org>; Thu, 14 Mar 2024 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710448202; cv=none; b=u8ue+NUnU7PVBBDTura+qydjZzzAFtypSFoPNj8J4WKMHNCB7HhkJSaAXBnID+dRGIk+GMtsSemaOUHhvbRsaWhY6qFJSGeGZ7FhI5a+Pv1D0D80qkNDEBZYa9Hm+qu+7HPcrIsNPqPLtb/ILsMFA18rXM8ALABK2W2u6uh2YO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710448202; c=relaxed/simple;
	bh=77zp9fuAG+eNbhPHMNMvab6wsRpLsYAwcwmgW03gA90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NOFGhPLKEK4WOyZMIPO8nzjUj5DoklvIN9e+HwVOIvT4hfBNgsBT9EoLqI2R2eOzbvGM2GZkftiKj16yNBAU+dmEQ4IJu4HyhqqL7AZzSy30/9ohsTND/SsErUrSmgKUqlsSPvIMKaQtVtEuF4pyxZRvoXhfva00THmPiuMYtjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=c1CpvgGp; arc=none smtp.client-ip=95.163.41.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	Disposition-Notification-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive:X-Cloud-Ids:
	Disposition-Notification-To; bh=BKIDbD4bmWHz0K3h/KVG3ZBgXVuA+DbiPhnbss/e0ec=;
	t=1710448199; x=1710538199; b=c1CpvgGpaTeEYyw4Afqj+7Mia68jRaLVFpQOlUOuUlzAUUG
	VrraO86Hm3M7Ew6O0kws2MaOwDm2vhrRutqiAP+aOKzamIrCK1X2aFgWzG1nilysD/mk0gj6PO0kn
	efyafAmup7OrWo+RjUsIrVOGcY7TAPqlx1sEB4Epm2jlJgTz8dE2Xw3c9ZPA4D4RObWLHg1M5GJs+
	ItY2De//98BqYnRIfmosPunQgKziuUElhaHl0Ah3VW/5ZK/u+neiPeU1ALlwLgp9H2wwTlkTDMS7V
	t0wnFB3a6Mhy2bA9J4h+G9UzQF6mYuStJYL+L2FaiIz0MD8wE+GjMrD/4g+HB15g==;
Received: by smtp55.i.mail.ru with esmtpa (envelope-from <listdansp@mail.ru>)
	id 1rkri2-0000000B6EL-1J9o; Thu, 14 Mar 2024 23:29:50 +0300
Message-ID: <82ba679e-cef5-bd0b-2084-ae601681cdec@mail.ru>
Date: Thu, 14 Mar 2024 23:29:49 +0300
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
From: listdansp <listdansp@mail.ru>
Disposition-Notification-To: listdansp <listdansp@mail.ru>
In-Reply-To: <20231220080729.GB136797@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp55.i.mail.ru; auth=pass smtp.auth=listdansp@mail.ru smtp.mailfrom=listdansp@mail.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD987C0EE6E7F0A597DDF776407DD463AED7AC1984F64828CE8182A05F53808504005168116014394A933594132A326AF8BE434A2F8D2D8EAE7380F4A25A4F8E9337350E528B29B8D5B
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE74323F140F3EE5B6AC2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE7DBCB4EBB860C672DEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B73AB1701401CD8713A6C3BF18E22E26B52469A9669D0D2F1320BDF0AEB5ACDC51DF9E95F17B0083B26EA987F6312C9ECCCD848CCB6FE560CBDFBBEFFF4125B51D2E47CDBA5A96583C09775C1D3CA48CF17B107DEF921CE79117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE71AE4D56B06699BBC9FA2833FD35BB23DF004C90652538430302FCEF25BFAB3454AD6D5ED66289B5278DA827A17800CE79CAD2DBC0234F62ED32BA5DBAC0009BE395957E7521B51C2330BD67F2E7D9AF1090A508E0FED6299176DF2183F8FC7C0C0EB1BCB97A81CACCD04E86FAF290E2DB606B96278B59C421DD303D21008E29813377AFFFEAFD269176DF2183F8FC7C0FE3A47D6FA29121068655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7C0EB31F42924FFA1243847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A53250BE9A60179B285002B1117B3ED6963F254835BBF604519E040399BDE4761E823CB91A9FED034534781492E4B8EEAD0942DC5495D0595EBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFB71FE1FB82C2A69BE879C432D4CA7FFF778A901DF789A89B621D5E2E189237E9506ED036F265C5427C77D8D956826D330CBA953A086091796E5D7BBB7A43E689138D97C2E542B69AC226CC413062362A913E6812662D5F2AF72BBD4AC8FF0C4E5649C4772AD793FE964550E41902C4E4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojXiTM5LlaqzKiDYPPaRD+Gw==
X-Mailru-Sender: 4CE1109FD677D2770147F6A9E21DCA7B9F35746BB57EAA9F459FBC39F2FFFE833567806687779DFFD53C8DA9176C40ABCE8DDCF05647143DC77752E0C033A69E3DC0BC7494A416CF0226C39053983FF0B4A721A3011E896F
X-Mras: Ok

-------- Original Message  --------
Subject: Re: mlx5 attr.max_sge checks
From: Leon Romanovsky <leon@kernel.org>
To: listdansp <listdansp@mail.ru>
Date: 20.12.2023

> On Tue, Dec 19, 2023 at 09:56:01PM +0300, listdansp wrote:
>> Hi,
>>
>> While investigating the one report of the static analyzer (svacer), it was
>> discovered that attr.max_sge was not checked for the maximum value in the
>> mlx5_ib_create_srq function. However, this check is present in
>> https://github.com/linux-rdma/rdma-core. Also, checks are present in most
>> other infiniband Linux Kernel drivers. This may lead to incorrect driver
>> operation for example
>> int mlx5_ib_read_wqe_srq(struct mlx5_ib_srq *srq, int wqe_index, void
>> *buffer, size_tbuflen, size_t*bc)
>> {
>> structib_umem*umem= srq->umem;
>> size_twqe_size= 1 << srq->msrq.wqe_shift; // integeroverflowhere
>> if(buflen< wqe_size)
>> return-EINVAL;
>> In my opinion, the only possible solution to this problem may be to add a
>> check to mlx5_ib_create_srq similar to
>> https://github.com/linux-rdma/rdma-core
>> <https://github.com/linux-rdma/rdma-core> like
>> u32 max_sge= MLX5_CAP_GEN(dev->mdev, max_wqe_sz_rq) /
>> sizeof(structmlx5_wqe_data_seg);
>> if (attr->attr.max_sge > max_sge) {
>> mlx5_ib_dbg
>> <https://elixir.bootlin.com/linux/v5.10.169/C/ident/mlx5_ib_dbg>(dev,
>> "max_sge%d, cap %d\n", init_attr
>> <https://elixir.bootlin.com/linux/v5.10.169/C/ident/init_attr>->attr.max_
>> <https://elixir.bootlin.com/linux/v5.10.169/C/ident/max_wr>sge, max_sge);
>> return -EINVAL <https://elixir.bootlin.com/linux/v5.10.169/C/ident/EINVAL>;
>> }
>>
>> I would appreciate your suggestions and comments.
> 
> Can you please provide an example of such values?
> 
> At least in the presented case, the values are supplied by FW and are
> supposed to be right without any overflows.
> 
> Thanks
> 
>>
>> Best regards,
>> Danila
>>
>>

Hi,

In the mlx5_ib_create_srq function, the variable srq->msrq.wqe_shift = 
ilog2(desc_size).
Value of  desc_size is result of desc_size = sizeof(struct 
mlx5_wqe_srq_next_seg) + srq->msrq.max_gs * sizeof(struct 
mlx5_wqe_data_seg);.
The init_attr->attr.max_sge parameter can be set to any 4-byte unsigned 
number.
There is overflow checking
if (desc_size == 0 || srq->msrq.max_gs > desc_size)
return -EINVAL;
but it works correctly only for 32-bit platforms because size_t 
desc_size; and for 64 bits platforms sizeof(size_t) is 8.
So, result of srq->msrq.wqe_shift = ilog2(desc_size) may be greater than 
31 and will cause overflow in size_t wqe_size = 1 << srq->msrq.wqe_shift;

Best regards,
Danila

