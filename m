Return-Path: <linux-rdma+bounces-19972-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GFQKhY2+WkG6gIAu9opvQ
	(envelope-from <linux-rdma+bounces-19972-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 02:13:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 210404C527B
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 02:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AD1D303CC04
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 00:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1152514B977;
	Tue,  5 May 2026 00:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRuKzQU2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A221342AB7
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 00:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939877; cv=none; b=cJ2xb7LMB+cbLWmcSOnUjjZzXvRkpAaVS9RsrrqLwQO8qlvYSrapVrG08ewc+T8AQw62pRlSb9/1VyUV6XUzJ79VghiBHz1XpiMiROfGWdZ31/r84l0Vj9G4acxg6gLrHtPr62aR6/BXBD9S9q2q5RtOrTkMVLktfpLgPpnpIFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939877; c=relaxed/simple;
	bh=vtW70XD7sgH1la6jbceNOWaOTwUM5D0j2nHs+xlyJC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tw2zLu3OopZQ6r0OBlmLEkmCSPH++GwW5CGSxvP30sgXQhpwKvC5z4rHEl6tMGZ1NlYSFIMBLwfsC90/iIZURvQiXCBOdlHGo2KX3DlTn2HoSehwLBHEtFOwemuffAWVSrjM3MGEfOrhH/82MuM8WyM88EK/AVoWtXyTJrXZRqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRuKzQU2; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ef8d6ba48bso1730154eec.1
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 17:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777939876; x=1778544676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qd/krIT/1cSoLMMya0JMIdHmRHAFdBg2W/mBeQ6dU54=;
        b=nRuKzQU206xVMp9eAtUnNmf67sbnZD3+J4gjRs8ChwWORJVg/na9VF5gyQAWNFsbgL
         PziIm0yt0j5CL6A51C7Ew83GfEgCkXav6LLZoTOcplx7Gg0RK73z2U/Eb2cNP0HxjfQT
         9/OslOLk2syPVQVl0yyMrYXndfLmjcjYduXDlHcOSWtVlCni+g4gtTwrcn0IHTJg/udg
         5u16gb4dNSPwVpM/xCWBWUR19QB93nGiE8/5fMmd/x1Y06EL7Gmzb1q+pQ0pkpfELF7n
         7rm1fZYrXZPfS6siwyFXedgx3nTun+dvx4eb5xzSNDM3exEmibvKrW3JJziaSTWSmlzZ
         4PxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777939876; x=1778544676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qd/krIT/1cSoLMMya0JMIdHmRHAFdBg2W/mBeQ6dU54=;
        b=ZrMMWkuSmRnySz5ugh/FnYDUleZKg4hL9z8dDg98fWbH3sVtdkBgLM3U8iW2OOZymk
         QkVa2uc2Ex7n4Ez3ME+43YcDXLa8o3Nu5aOk8pt15RB/jFskxyp+pln2ARf+r/YBKMW7
         +3eolxyPaMlsK81gQoNeJJIwy+hsk4o2q53klMrQRMYsGRr0PmJX4ZKawj6D6rPv1JkH
         EzqwXfqgzWy1jXUkVAIpVCG/S/uloqjisYUvLslUGU4BUadJnULebuyLgCLbpeUuD7+E
         ANWArBNmaB/s2e8dzOezwwGnjTqIt7agE9UXgxqU3wNjVh+h1DnLkW0o+icPetZG3nI/
         atKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9YS7zDmPWeXOcrufjyWRPU3k/j1V9buiIoI2APm7nsXBjrfllnhBi/hUAxDC5OaGSP1iv3fEQ+p13O@vger.kernel.org
X-Gm-Message-State: AOJu0YwvTmlm8A/IZLuFsEQv0rP824KNEL/AyYva7oG7DJG+Qr9TWWar
	uoi6Pl4i9EO1Ud5LgicE1pdDI/FRxzfFZMj6RaaVxR1sawycKe8VK54=
X-Gm-Gg: AeBDieuSd+rBeg+NFSBQ28CbYX9pgb9xR25tuzhJzSspV//Z+t9KbIZ+/wStf3rZsX0
	MnYDPoJTVXlAUt/DAgtEcoRgNRuK2qMtwYq/20l4Yc49izg7yTtztBwt5lNNuGyi6mwzeIe8N+x
	DK8siUKA8pDUtyFkNkC5iKAmZFbPxzYzJ8CkBO10sk501g8kqEPgg24T6aY46JHJhD6RGU1o/oY
	GVfPE1mOyIWdl61q6XQu9jG69+mq7kWVsTxM1EE0e4VCN1sAJ+LY/IANSIULYdEjIsjz2LA7F+J
	0hkOa6HlL2xBZM0OYCYP7Ug47jWIXK0DfPnBg4LGW0gWMvwKtD0kwSxtwoNFN4MvNXFonD+zF9P
	ZSeXleip0OdDcK8GOSiAvDgwmXSMvHJyql/EUapDcmT3gHRQaWKstN0VK7npXggplW7HTncsmpw
	D0uL2VjSVtAv1jmUHaA9AqvXfZr0UzOXEjAmhrBfd2O7uVox1IHQyLDwZmvtcjj30+xuNPGFiUb
	bJAjEvn
X-Received: by 2002:a05:7300:ca8:b0:2f3:b7b2:cbd3 with SMTP id 5a478bee46e88-2f3ce9f1febmr945308eec.5.1777939875407;
        Mon, 04 May 2026 17:11:15 -0700 (PDT)
Received: from [10.100.6.77] (LAMBDA-INC.bar2.SanFrancisco1.Level3.net. [4.7.9.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm24529936eec.8.2026.05.04.17.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 17:11:15 -0700 (PDT)
Message-ID: <bdb04831-1c40-4744-a0b9-395b849127cb@gmail.com>
Date: Mon, 4 May 2026 17:11:13 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/srpt: fix integer overflow in immediate data length
 check
To: Bart Van Assche <bvanassche@acm.org>, jgg@ziepe.ca
Cc: leon@kernel.org, dledford@redhat.com, linux-rdma@vger.kernel.org,
 target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
 carlos.bilbao@kernel.org
References: <20260504080036.3482415-1-sarajvenkatesh@gmail.com>
 <dbc57009-f563-4858-91f1-a63efe786d01@acm.org>
Content-Language: en-US
From: Sara Venkatesh <sarajvenkatesh@gmail.com>
In-Reply-To: <dbc57009-f563-4858-91f1-a63efe786d01@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 210404C527B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19972-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sarajvenkatesh@gmail.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi Bart,

Yes, tested with blktests srp suite against this patch on 7.1.0-rc2:

srp/001 ... [passed]
srp/002 ... [passed]
srp/005 ... [passed]
srp/006 ... [passed]
srp/007 ... [passed]
srp/008 ... [passed]
srp/009 ... [passed]
srp/010 ... [passed]
srp/011 ... [passed]
srp/012 ... [passed]
srp/013 ... [passed]
srp/014 ... [passed]
srp/016 ... [passed]

srp/003 and srp/004 are [not run] (legacy device mapper support missing).

Thanks,
Sara

On 5/4/26 01:17, Bart Van Assche wrote:
> On 5/4/26 10:00 AM, Sara Venkatesh wrote:
>> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c 
>> b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> index 9aec5d80117f..f66cfd70c263 100644
>> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
>> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> @@ -1129,9 +1129,10 @@ static int srpt_get_desc_tbl(struct 
>> srpt_recv_ioctx *recv_ioctx,
>>           struct srp_imm_buf *imm_buf = srpt_get_desc_buf(srp_cmd);
>>           void *data = (void *)srp_cmd + imm_data_offset;
>>           uint32_t len = be32_to_cpu(imm_buf->len);
>> -        uint32_t req_size = imm_data_offset + len;
>> +        uint32_t req_size;
>>   -        if (req_size > srp_max_req_size) {
>> +        if (check_add_overflow((uint32_t)imm_data_offset, len, 
>> &req_size) ||
>> +            req_size > srp_max_req_size) {
>>               pr_err("Immediate data (length %d + %d) exceeds request 
>> size %d\n",
>>                      imm_data_offset, len, srp_max_req_size);
>>               return -EINVAL;
>
> Do the srp tests from https://github.com/linux-blktests/blktests/ still
> pass with this patch applied?
>
> Thanks,
>
> Bart.

