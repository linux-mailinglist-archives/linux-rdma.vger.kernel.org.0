Return-Path: <linux-rdma+bounces-2860-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD588FBD2A
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 22:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C30D1C227A8
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 20:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D218513E8BF;
	Tue,  4 Jun 2024 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="sUW/OtAg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83DB83CD6
	for <linux-rdma@vger.kernel.org>; Tue,  4 Jun 2024 20:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717532156; cv=none; b=ODfkm/kWEQYQepOcJISMvS7rjVoDRSCOi3zkdIIsmvkck3JqjkHjiYMEm+mcJkjgl1FdRDJimQlvR2/8X1mi6iEKhonp5v2q3+VBIUeAFfP6XicUsO3Z0tO0Fv46k661+tEYYnd/XoPg0nyoSFah/rKN/qcordyXeiexMkTS/4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717532156; c=relaxed/simple;
	bh=As2GM26ltn9/ek8pg/99VnQ6oy6MDY21xD2Sp9hdv/g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=FirdqPAiIlIU55PjqriB1NcOycqGtl3n9o6K80uiD2Bw8zU/DC/RjcO7fb/BFUOuwr0/i+QONf0nLquYwRz+Hoe4bJNs8rWmbyAJDRkdWLPgLw7r1crV+D0X6G39X8lH4OC1k16Y5J6Lwd13/i73CCLbW6R7K9pfW3G0Fz84T7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=sUW/OtAg; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Vv20N4SzCzlgMVX;
	Tue,  4 Jun 2024 20:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:content-language:references:subject:subject:from:from
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717532145; x=1720124146; bh=IhobA/nARMJe05sx5W26Xa/l
	u3fRW0jArbLkFW/wjRc=; b=sUW/OtAgbM7TuFTgKH+VmfvxaWV5rgA+PBlPXmhM
	tQEU149xBJcasIzGikC5eMbaYZbtTTG4z5e1Jx3nZJE+aLNkHSYovBwF9I/xRG1h
	4yPabTggSOE254hj+0q9XKXRjGL2a2pyy4H3dr6qY3J6CnguFco4zuRDqm+tgSOu
	d9hvYWtUMJE2T+RUvf62JEqVNdNGY1MDq0sKLF1Iie15hRfboDcwRBV/gMfjT8zv
	gJvkfsp6aGiBSTBKYEaDU/AloGcY7kei8gPMOs5qCKm7DVG1FSmWIYduX0EfP8hj
	sbDy6rynQ0uq0lFNxo/fVskw1h8rBsOP7GGuQYTt9JYi2g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Ljj4e1xZqFTB; Tue,  4 Jun 2024 20:15:45 +0000 (UTC)
Received: from [192.168.132.235] (unknown [65.117.37.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Vv20K2tWCzlgMVV;
	Tue,  4 Jun 2024 20:15:45 +0000 (UTC)
Message-ID: <a21021bf-6866-466b-a924-2f465fbb2e64@acm.org>
Date: Tue, 4 Jun 2024 14:15:44 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [bug report] KASAN slab-use-after-free at blktests srp/002 with
 siw driver
To: Zhu Yanjun <yanjun.zhu@linux.dev>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
References: <5prftateosuvgmosryes4lakptbxccwtx7yajoicjhudt7gyvp@w3f6nqdvurir>
 <6bcbe337-c2fe-46ee-8228-a3cff6852c28@linux.dev>
Content-Language: en-US
In-Reply-To: <6bcbe337-c2fe-46ee-8228-a3cff6852c28@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/24 03:26, Zhu Yanjun wrote:
> 
> On 04.06.24 09:25, Shinichiro Kawasaki wrote:
>> As I noted in another thread [1], KASAN slab-use-after-free is 
>> observed when
>> I repeat the blktests test case srp/002 with the siw driver [2]. The 
>> kernel
>> version was v6.10-rc2. The failure is recreated in stable manner when 
>> the test
>> case is repeated around 30 times. It was not observed with the rxe 
>> driver.
>>
>> I think this failure is same as that I reported in Jun/2023 [3]. The 
>> Call Trace
>> reported is quite similar. Also, I confirmed that the trial fix patch 
>> that I
>> created in Jun/2023 avoided the KASAN failure at srp/002.
> 
> "the trial fix patch that I created in Jun/2023" that you mentioned is 
> the commit in the link?
> 
> https://lore.kernel.org/linux-rdma/20230612054237.1855292-1-shinichiro.kawasaki@wdc.com/

To me that patch doesn't seem correct. Jason and Leon, is my understanding
correct that you are the maintainers for the iwcm code? Can you please help
with reviewing this patch?

Thanks,

Bart.

 From 879ca4e5f9ab8c4ce522b4edc144a3938a2f4afb Mon Sep 17 00:00:00 2001
From: Bart Van Assche <bvanassche@acm.org>
Date: Tue, 4 Jun 2024 12:49:44 -0700
Subject: [PATCH] RDMA/iwcm: Fix a use-after-free related to destroying CM IDs

iw_conn_req_handler() associates a new struct rdma_id_private (conn_id) with
an existing struct iw_cm_id (cm_id) as follows:

         conn_id->cm_id.iw = cm_id;
         cm_id->context = conn_id;
         cm_id->cm_handler = cma_iw_handler;

rdma_destroy_id() frees both the cm_id and the struct rdma_id_private. Make
sure that cm_work_handler() does not trigger a use-after-free by delaing
freeing of the struct rdma_id_private until all pending work has finished.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  drivers/infiniband/core/iwcm.c | 11 +++++++----
  1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index d608952c6e8e..ea9dc26bf563 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -368,8 +368,10 @@ EXPORT_SYMBOL(iw_cm_disconnect);
   *
   * Clean up all resources associated with the connection and release
   * the initial reference taken by iw_create_cm_id.
+ *
+ * Returns true if and only if the last cm_id_priv reference has been dropped.
   */
-static void destroy_cm_id(struct iw_cm_id *cm_id)
+static bool destroy_cm_id(struct iw_cm_id *cm_id)
  {
  	struct iwcm_id_private *cm_id_priv;
  	struct ib_qp *qp;
@@ -439,7 +441,7 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
  		iwpm_remove_mapping(&cm_id->local_addr, RDMA_NL_IWCM);
  	}

-	(void)iwcm_deref_id(cm_id_priv);
+	return iwcm_deref_id(cm_id_priv);
  }

  /*
@@ -450,7 +452,8 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
   */
  void iw_destroy_cm_id(struct iw_cm_id *cm_id)
  {
-	destroy_cm_id(cm_id);
+	if (!destroy_cm_id(cm_id))
+		flush_workqueue(iwcm_wq);
  }
  EXPORT_SYMBOL(iw_destroy_cm_id);

@@ -1031,7 +1034,7 @@ static void cm_work_handler(struct work_struct *_work)
  		if (!test_bit(IWCM_F_DROP_EVENTS, &cm_id_priv->flags)) {
  			ret = process_event(cm_id_priv, &levent);
  			if (ret)
-				destroy_cm_id(&cm_id_priv->id);
+				WARN_ON_ONCE(destroy_cm_id(&cm_id_priv->id));
  		} else
  			pr_debug("dropping event %d\n", levent.event);
  		if (iwcm_deref_id(cm_id_priv))


