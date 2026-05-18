Return-Path: <linux-rdma+bounces-20872-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH8BIEJ7Cmqe1wQAu9opvQ
	(envelope-from <linux-rdma+bounces-20872-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 04:36:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAA2565208
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 04:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F16993009998
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 02:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E002264C7;
	Mon, 18 May 2026 02:36:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A917DFE7
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 02:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779071805; cv=none; b=SEG43VhJ+TvR56Gr2wnQsTDpwT5FMtZEO7IA4CwxGK5ffgKlXu8JwsbRelajYEbgIKoekBhM8B9ZDQ/hOzRmHLdmyWUAqsUewrjrnanWdwtJ3bMOmH/6pxngK+v3UkLTeNSl5CEJYN8+seMbN5/iepTS9JQGW9FzwEPpPjX3dNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779071805; c=relaxed/simple;
	bh=XKiJKVFxjTiyvPvHS/CS16I/+h+7wGXboAm17SypzjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MremG5E5Io0+3O9OtgH5Rhpk+tUkJmtazznBj0IENeD+Dq7YDwl9W1UQalGkPVfi7dCKBb82zUG9XK1eA7X5VGG5jEYQlmVsQ1lda4Cx1xDq8baxa9xIlamVQe8X8dQQ1v5OFVXczTOzvWr7m8wpXTNHePzq3sZfMNw3VD4kq+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 63f16a98526211f1aa26b74ffac11d73-20260518
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:5f5f1c75-b5e7-4b45-8f74-9ea5edf4f766,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:5f5f1c75-b5e7-4b45-8f74-9ea5edf4f766,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:65f82eb1df9a0239de1b456fcdc91b64,BulkI
	D:260517183253IRROVRYW,BulkQuantity:2,Recheck:0,SF:10|64|66|78|80|81|82|83
	|102|127|841|865|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil,RT
	:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:
	0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 63f16a98526211f1aa26b74ffac11d73-20260518
X-User: zhaochenguang@kylinos.cn
Received: from [192.168.111.102] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1894424987; Mon, 18 May 2026 10:36:36 +0800
Message-ID: <a7c17297-6c80-48c1-aa8c-c729afc84f30@kylinos.cn>
Date: Mon, 18 May 2026 10:36:57 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] IB/cache: Check GID table references before attempting
 deletion
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <kees@kernel.org>,
 Etienne AUJAMES <eaujames@ddn.com>, zhenwei pi <zhenwei.pi@linux.dev>,
 Jiri Pirko <jiri@resnulli.us>, Maor Gottlieb <maorg@nvidia.com>,
 linux-rdma@vger.kernel.org
References: <20260513080707.3929955-1-zhaochenguang@kylinos.cn>
 <20260517103240.GC33515@unreal>
Content-Language: en-US
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
In-Reply-To: <20260517103240.GC33515@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EFAA2565208
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,kylinos.cn:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FROM_NEQ_ENVFROM(0.00)[zhaochenguang@kylinos.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-20872-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action

      After calling kref_put(&entry->kref) in put_gid_entry_locked(), the reference count does not drop to zero. 

This is because the GID entry is still held by NFS via call paths such as

cma_acquire_dev_by_src_ip() -> cma_validate_port() -> rdma_find_gid_by_port() -> get_gid_entry().

Consequently, the GID entry cannot be freed. Meanwhile, the corresponding GID has already been removed 

from hardware/driver layer via ib_dev->ops.del_gid(). Subsequent ifup attempts keep inserting new entries

 into the GID table, and repeated cycles of ifdown and ifup eventually exhaust the entire GID table space.

       To resolve this issue, we add a check before removing GID entries in the driver. We forbid the deletion

 operation if entry->kref is not equal to 1 (the initial reference count value). With this constraint, existing 

valid entries will be detected and reused after ifup, avoiding redundant insertion into the GID table.


Will GID entry deletion lead to inconsistency between driver and IB/cache layers?

Thanks
Chenguang

在 2026/5/17 18:32, Leon Romanovsky 写道:
> On Wed, May 13, 2026 at 04:07:07PM +0800, Chenguang Zhao wrote:
>> In the NFS over RDMA environment, repeatedly performing frequent
>> ifdown/ifup operations on the client may cause df -h to hang.
>> The kernel log reports an error:
>>   __ib_cache_gid_add: unable to add gid
>>   0000:0000:0000:0000:0000:ffff:c0a8:0115 error=-28.
>> Error code -28 indicates the GID table is full.
>> The call stack during ifdown is as follows:
>>   put_gid_entry_locked()
>>   del_gid()
>>   _ib_cache_gid_del()
>>   update_gid()
>>   update_gid_event_work_handler()
>>
>> In put_gid_entry_locked(), kref_put(&entry->kref) does not
>> drop the reference count to zero.
> Why?
>
>> so free_gid_entry() is never invoked to release the entry. Subsequent ifup
>> attempts keep adding new entries into the GID table,
>> eventually exhausting the table capacity.
> This behavior is not what we expect from the IB/cache layer.
>
> Thanks
>
>> To fix this, check whether the GID entry still has
>> outstanding references in del_gid(), and only remove
>> and release the entry when no other references remain.
>>
>> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
>> ---
>>  drivers/infiniband/core/cache.c | 31 +++++++++++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>
>> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
>> index 647a547e2d7f..c71522fbf89f 100644
>> --- a/drivers/infiniband/core/cache.c
>> +++ b/drivers/infiniband/core/cache.c
>> @@ -596,6 +596,34 @@ int ib_cache_gid_add(struct ib_device *ib_dev, u32 port,
>>  	return __ib_cache_gid_add(ib_dev, port, gid, attr, mask, false);
>>  }
>>  
>> +/**
>> + * gid_table_is_shared - Check if GID table has other reference owners
>> + * @table: GID table to check
>> + * @ix: index of entry
>> + *
>> + * Returns true if the gid table refcount is greater than 1,
>> + */
>> +static bool gid_table_is_shared(struct ib_gid_table *table, int ix)
>> +{
>> +	unsigned int refcount;
>> +	struct ib_gid_table_entry *entry;
>> +
>> +	write_lock_irq(&table->rwlock);
>> +
>> +	entry = table->data_vec[ix];
>> +	refcount = kref_read(&entry->kref);
>> +
>> +	write_unlock_irq(&table->rwlock);
>> +
>> +	if (refcount > 1) {
>> +		pr_debug("%s: The GID table is still referenced and cannot be deleted.\n",
>> +			__func__);
>> +		return true;
>> +	} else {
>> +		return false;
>> +	}
>> +}
>> +
>>  static int
>>  _ib_cache_gid_del(struct ib_device *ib_dev, u32 port,
>>  		  union ib_gid *gid, struct ib_gid_attr *attr,
>> @@ -615,6 +643,9 @@ _ib_cache_gid_del(struct ib_device *ib_dev, u32 port,
>>  		goto out_unlock;
>>  	}
>>  
>> +	if (gid_table_is_shared(table, ix))
>> +		goto out_unlock;
>> +
>>  	del_gid(ib_dev, port, table, ix);
>>  	dispatch_gid_change_event(ib_dev, port);
>>  
>> -- 
>> 2.25.1
>>
>>

