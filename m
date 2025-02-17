Return-Path: <linux-rdma+bounces-7797-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0634AA38B51
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 19:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB683188EDFA
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 18:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A313236428;
	Mon, 17 Feb 2025 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Zurvsbxo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5713C235C17;
	Mon, 17 Feb 2025 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739817218; cv=none; b=P07JAn6gGITvD+iBAkHzLdue1K57lrnPuJgnEX1lZJl3nxgCN4I4c7Xv0SjrasmBb79W0vWQCRwNPH0wLlmNdQT/90XYBQL/mco+Uq0yoFlQ2rtqCKSh1ywzyJP3KrcOlMZjleeQuYic1mZGImHJX5uqPdtAE3QVUFx7fVCal+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739817218; c=relaxed/simple;
	bh=mWA6LwZaNx5JAKV6QJvtDnCrVSR29qBNMOGxkOwnBE0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EBH8GZE46i+9SjBEmEGugikZXYriIV4G9Co92smJ2JwCuqMTdwA0GP4PS4y7ljV1Yon6+mgh+250ZColCuya4UtuSG+lEdaK3/7YV6abq5Cy8xL983Ru66g9kKiXp39NvNmrIlJgo+FiOs9g5fStvJHFwFU5QlPPsQYKZ/eqp1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Zurvsbxo; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1739817214; x=1740076414;
	bh=CW0qxI9h5eGxlQ4r4oYwixyEbl2p3EVe1CFqW9ivxwg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ZurvsbxomNAtPXskg33Wf5c4fkZfvt6I+B7K8Jao90he/zXGeuEq1y5G3lM9fkgoJ
	 XtTKiU82J+4a1A+pOqHSH7udOOO7GQ2auE/Ch3WQDZ+nPTPRSQYlRx7QSbnSRKYtpw
	 LnFssfNwsgWhTXSOkJgalqIDRZudB8m2AEPWJSRgBs6zxKpRUGCzJ1hMQ84dU+Ge8W
	 THUjEoHjqNzV1zn6V9pgQRchA1sYTb1rmyiGznEmQlW/D6MpPlpeq0KDK+51iKdQGG
	 YrCWnWjqU3S5T5duwG1trb6XhADtGATUvGXSlUXgCZ7awTIEcnLvFjN/MRfUE4n27F
	 MmYB7VSKFPZww==
Date: Mon, 17 Feb 2025 18:33:28 +0000
To: Max Gurtovoy <mgurtovoy@nvidia.com>, shuah@kernel.org, sagi@grimberg.me, jgg@ziepe.ca, leon@kernel.org
From: Imanol Valiente <imvalient@protonmail.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: iscsi_iser: fix typos in comments
Message-ID: <015170a5-b368-46bb-bc7c-30d9a41379c0@protonmail.com>
In-Reply-To: <e123e1c9-21d1-4136-a26a-931135c477d3@nvidia.com>
References: <20250216235602.177904-1-imvalient@protonmail.com> <e123e1c9-21d1-4136-a26a-931135c477d3@nvidia.com>
Feedback-ID: 28866602:user:proton
X-Pm-Message-ID: 082904498e92cc3a62d2918a089fc382fb321e31
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for the review. I have sent PATCH v2 with the updated commit=20
title as suggested.

El 17/2/25 a las 1:27, Max Gurtovoy escribi=C3=B3:
>=20
> On 17/02/2025 1:56, Imanol wrote:
>> Fixes multiple occurrences of the misspelled word "occured" in the comme=
nts
>> of `iscsi_iser.c`, replacing them with the correct spelling "occurred".
>>
>> This improves readability without affecting functionality.
>>
>> Signed-off-by: Imanol <imvalient@protonmail.com>
>> ---
>>    drivers/infiniband/ulp/iser/iscsi_iser.c | 8 ++++----
>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniba=
nd/ulp/iser/iscsi_iser.c
>> index bb9aaff92ca3..a5be6f1ba12b 100644
>> --- a/drivers/infiniband/ulp/iser/iscsi_iser.c
>> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
>> @@ -393,10 +393,10 @@ static void iscsi_iser_cleanup_task(struct iscsi_t=
ask *task)
>>     * @task:     iscsi task
>>     * @sector:   error sector if exsists (output)
>>     *
>> - * Return: zero if no data-integrity errors have occured
>> - *         0x1: data-integrity error occured in the guard-block
>> - *         0x2: data-integrity error occured in the reference tag
>> - *         0x3: data-integrity error occured in the application tag
>> + * Return: zero if no data-integrity errors have occurred
>> + *         0x1: data-integrity error occurred in the guard-block
>> + *         0x2: data-integrity error occurred in the reference tag
>> + *         0x3: data-integrity error occurred in the application tag
>>     *
>>     *         In addition the error sector is marked.
>>     */
>=20
> We usually use: "IB/iser:" prefix in the commit msg subject.
>=20
> Can you please replace "infiniband: iscsi_iser: fix typos in comments"
> with "IB/iser: fix typos in iscsi_iser.c comments" ?
>=20
> Other than that, looks good.
>=20
> Acked-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>=20



