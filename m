Return-Path: <linux-rdma+bounces-458-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6CF819123
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Dec 2023 21:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85462872AB
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Dec 2023 20:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ED239863;
	Tue, 19 Dec 2023 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="soG4RZl1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="gHv+ZucQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fallback13.i.mail.ru (fallback13.i.mail.ru [79.137.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D5C39FE0
	for <linux-rdma@vger.kernel.org>; Tue, 19 Dec 2023 19:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:References:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=JSkekOjjf/syH7TXgO/vCeXmhD1M2LKvnKgQtef7+go=;
	t=1703015982;x=1703105982; 
	b=soG4RZl1nBWqkJG/e+CllPLDCzuCkapGjo+B1fiGk7vxzZxkrgQQF3lrKFFSDCpNKcS10bwxNoH0ji7yLpgougUPRGshv93/ALIW0fteGWk4o52cCvXyYC9AH/ZlnVqATOhJ2H3U02gB5HP2NHXdHhemaONzSMGtcgJ0v59S3t7IkJGW/QsBaG65wk9GJoBCeyG6ZV5iYDjYc+OSEcbhKlQrn9DWUILJcsxImKAMtvmsZy+z51h38Q77x6QXBiHHvsTyfKjqiHbMkVG4c2HsXAP0EfsD8zUTTli2nEbvYM9SajN6ZE5IOU+9L3bRVkri8LUDs1GrBirOBzyuhnWqew==;
Received: from [10.12.4.31] (port=55228 helo=smtp56.i.mail.ru)
	by fallback13.i.mail.ru with esmtp (envelope-from <listdansp@mail.ru>)
	id 1rFfvx-000wfw-Gc
	for linux-rdma@vger.kernel.org; Tue, 19 Dec 2023 22:39:17 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	Disposition-Notification-To:From:Cc:References:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive:X-Cloud-Ids:
	Disposition-Notification-To; bh=JSkekOjjf/syH7TXgO/vCeXmhD1M2LKvnKgQtef7+go=;
	t=1703014757; x=1703104757; b=gHv+ZucQJPFBH2gVWi5d83ypb7fWDD+CqFXiSs0nHhGMttB
	dPn+//rQR5KVsZJhCzW88T+myPji62SxmAxRN0aOdszRqpmZJ3bSUn3gB6Vrv4ghdo80vxOWTSS5p
	vdjrYTbrR+0IpCnQ2sb4HPykxCT54o6MwWzN1yayu5qo7HWQi/JPER6VQCzQ9xWxyZugznzsa2w1U
	A3TOY90YbCRNRQDxlGnOmAVsC1Sx/i8gUlUJMRkbRzWrJsP5ZUIAAPt5PgLbNCsqbT+ZRKIM/Ys96
	dw9fEXk1AOQpY17zD7kBeLqhRvwx1+zPNMZpL/eMbGSKZYHAjuFZA4JemCixgjfw==;
Received: by smtp56.i.mail.ru with esmtpa (envelope-from <listdansp@mail.ru>)
	id 1rFfvj-00DzMq-0x; Tue, 19 Dec 2023 22:39:03 +0300
Message-ID: <62436d26-3c5c-aa10-b82c-4410fbbe9b1c@mail.ru>
Date: Tue, 19 Dec 2023 22:39:02 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: mlx5 attr.max_sge checks
Content-Language: ru
To: leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca
References: <1703013183-24379-mlmmj-3a1ea6ac@vger.kernel.org>
Cc: linux-rdma@vger.kernel.org
From: listdansp <listdansp@mail.ru>
Disposition-Notification-To: listdansp <listdansp@mail.ru>
In-Reply-To: <1703013183-24379-mlmmj-3a1ea6ac@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD97533543916A0F71A7F5FD72A6F01437A2062B641662DAC10CD62213F67905E7A2747D5BCC6C3E5AF654CA78D9D1A626D5CE894BBB38A107E0DE140DF427568CF
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE762F001A90027CA0CC2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE706CBCB8C0AB1BC4FEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B73AB1701401CD8717D4EC1DBA89AC1D3D1BD1036CD1CD06820879F7C8C5043D14489FFFB0AA5F4BF1661749BA6B977358794E14F7ADDB10D8941B15DA834481FA18204E546F3947CD2DCF9CF1F528DBCF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637F924B32C592EA89F389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F7900637B4C266A59E6A0C46D81D268191BDAD3DBD4B6F7A4D31EC0BE2F48590F00D11D6D81D268191BDAD3D78DA827A17800CE79CAD2DBC0234F62EEC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5278DA827A17800CE78F196494AD86DCAD2EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE7F9581457D50944AB731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A517A3D1DFC377942A5DC6F57979675B685ADE586EA7C16CD0F87CCE6106E1FC07E67D4AC08A07B9B064E7220B7C5505929C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF0F76270F0A8DFBCB5FF4557C4127DDD5BBCA2D9CF9CC88BE9590823B57DA54EE284AB208DE0D1BB1E190DC598EAEA94FFBD58A8C741B4607FAA7ED8124A7FDCFA74DFFEFA5DC0E7F02C26D483E81D6BE1622D42B0D48DA1897021655C84034CFF0A6D2C91ED28CB6
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojYtkvzPaMmB6EiGHfUP8tLg==
X-Mailru-Sender: 4CE1109FD677D2770147F6A9E21DCA7B1CBD3524A56AB0843F24B9FF8AE98EF27F72FD02116BEB297E3C9C7AF06D9E7B78274A4A9E9E44FD3C3897ABF9FF211DE8284E426C7B2D9A5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B43D177111D18C9608537746443B7E8395CC7CC0F4B5FCE887049FFFDB7839CE9E8F069D011BA1F8AA4911269011CF60612E18ABDCB458958D2F99D07B6B964BC6
X-7FA49CB5: 0D63561A33F958A5BEEA22B76F3CBC6086BB0D89E45CF8121E476B0607236BA5CACD7DF95DA8FC8BD5E8D9A59859A8B6E36167FF85871AA3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFd13/ESPkUJS3pjUUzX7g7LA==
X-Mailru-MI: C000000000000800
X-Mras: Ok

Hi,

While investigating the one report of the static analyzer (svacer), it 
was discovered that attr.max_sge was not checked for the maximum value 
in the mlx5_ib_create_srq function. However, this check is present in 
https://github.com/linux-rdma/rdma-core. Also, checks are present in 
most other infiniband Linux Kernel drivers. This may lead to incorrect 
driver operation for example

int mlx5_ib_read_wqe_srq(struct mlx5_ib_srq *srq, int wqe_index, void 
*buffer, size_t buflen, size_t *bc)
{
     struct ib_umem *umem = srq->umem;
     size_t wqe_size = 1 << srq->msrq.wqe_shift; // integer overflow here
     if (buflen < wqe_size)
         return -EINVAL;

In my opinion, the only possible solution to this problem may be to add 
a check to mlx5_ib_create_srq similar to 
https://github.com/linux-rdma/rdma-core like

u32 max_sge = MLX5_CAP_GEN(dev->mdev, max_wqe_sz_rq) / sizeof(struct 
mlx5_wqe_data_seg);
if (attr->attr.max_sge > max_sge) {
     mlx5_ib_dbg(dev, "max_sge %d, cap %d\n", init_attr->attr.max_sge, 
max_sge);
     return -EINVAL;
}

I would appreciate your suggestions and comments.

Best regards,
Danila

