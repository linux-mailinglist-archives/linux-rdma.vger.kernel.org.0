Return-Path: <linux-rdma+bounces-8096-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9315CA44E71
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 22:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D597A6D38
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 21:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A1320F06E;
	Tue, 25 Feb 2025 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Nt/l6W83"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-79.smtpout.orange.fr [80.12.242.79])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C791A0BCD;
	Tue, 25 Feb 2025 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740517820; cv=none; b=CPjpIWXMQjmv/dgXNmHbsuQC72eHOInALzrKV+NIt+Pk/6qaCT9zPIU7JLFxfr64gyzVmMZ9AXUE9oDdMdprpHWndsf4Nxd0tDGUEq1LqYwEKBSCit4M8nRbIfJmGHFcSvy0dGzLW9+EJVzwwghsIqpC8n4L96PB/fKmtP+h734=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740517820; c=relaxed/simple;
	bh=T3EHka1tFcSlRH3Fj1NbaXNKSeWHzxd6Y1SaHsloxZc=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=OMSxxy09yHyr5JRC4L90nckq1gkJsZ0VzhYPSNe1S4gqrj4/Sg6aX3L52A32RVGDTY24HGpC8jthghHmGVTspnWSkdY9seZNTRXpz+pJPZTMovLzBTstSsMn+HuXbDBkDvX5MSC57JpbsiX9d0DOM3pu5oCIIumdb/ZEVTU5Ijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Nt/l6W83; arc=none smtp.client-ip=80.12.242.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id n2BftCcRTqJDFn2BitbctU; Tue, 25 Feb 2025 22:10:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1740517809;
	bh=tARq/I59R/ifvYF0dCCLUoCvyYc1ZBk7Dm3FuvihB2s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=Nt/l6W83BU5mDSrDQIQy8CZKAo0h68PJvcKps3BRoVn2m6bAUl1vWhK2es/BP8BFW
	 DN3RlPUQFqJK58J49zS8Iq+H8FIQKGC4aR3FLiDA6idBgn8tIg5Twr41t+eDK/0sPp
	 mg1FQKV8UkENBVw737LGxuMBZo+ZBM/oK6VglExOrG9+5UCmVjY6kqG7UnMc6VpiKZ
	 s5Dl6bX1iLuElode1uDwU8GHn7T6IquRWeHKn8Hf+NPHn6mqYOqdxW2q2i+4k7lkXn
	 e6Eo2vgp4trckiymDN9vhHfOlmyq2Gyk1kUlSKjSw+1pc9JkNq2cH1UTJN+cQ2XgrM
	 /ezXxEpZ+Rm3Q==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 25 Feb 2025 22:10:09 +0100
X-ME-IP: 90.11.132.44
Message-ID: <e53d7586-b278-4338-95a2-fa768d5d8b5e@wanadoo.fr>
Date: Tue, 25 Feb 2025 22:09:55 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/16] rbd: convert timeouts to secs_to_jiffies()
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-6-a43967e36c88@linux.microsoft.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Frank.Li@nxp.com, James.Bottomley@HansenPartnership.com,
 Julia.Lawall@inria.fr, Shyam-sundar.S-k@amd.com, akpm@linux-foundation.org,
 axboe@kernel.dk, broonie@kernel.org, cassel@kernel.org, cem@kernel.org,
 ceph-devel@vger.kernel.org, clm@fb.com, cocci@inria.fr,
 dick.kennedy@broadcom.com, djwong@kernel.org, dlemoal@kernel.org,
 dongsheng.yang@easystack.cn, dri-devel@lists.freedesktop.org,
 dsterba@suse.com, festevam@gmail.com, hch@lst.de, hdegoede@redhat.com,
 hmh@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, idryomov@gmail.com,
 ilpo.jarvinen@linux.intel.com, imx@lists.linux.dev,
 james.smart@broadcom.com, jgg@ziepe.ca, josef@toxicpanda.com,
 kalesh-anakkur.purayil@broadcom.com, kbusch@kernel.org,
 kernel@pengutronix.de, leon@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-xfs@vger.kernel.org,
 martin.petersen@oracle.com, nicolas.palix@imag.fr, ogabbay@kernel.org,
 perex@perex.cz, platform-driver-x86@vger.kernel.org, s.hauer@pengutronix.de,
 sagi@grimberg.me, selvin.xavier@broadcom.com, shawnguo@kernel.org,
 sre@kernel.org, tiwai@suse.com, xiubli@redhat.com, yaron.avizrat@intel.com
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-6-a43967e36c88@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 25/02/2025 à 21:17, Easwar Hariharan a écrit :
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication
> 
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
> 
> @depends on patch@ expression E; @@
> 
> -msecs_to_jiffies(E * 1000)
> +secs_to_jiffies(E)
> 
> @depends on patch@ expression E; @@
> 
> -msecs_to_jiffies(E * MSEC_PER_SEC)
> +secs_to_jiffies(E)
> 
> While here, remove the no-longer necessary check for range since there's
> no multiplication involved.

I'm not sure this is correct.
Now you multiply by HZ and things can still overflow.


Hoping I got casting right:

#define MSEC_PER_SEC	1000L
#define HZ 100


#define secs_to_jiffies(_secs) (unsigned long)((_secs) * HZ)

static inline unsigned long _msecs_to_jiffies(const unsigned int m)
{
	return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
}

int main() {

	int n = INT_MAX - 5;

	printf("res  = %ld\n", secs_to_jiffies(n));
	printf("res  = %ld\n", _msecs_to_jiffies(1000 * n));

	return 0;
}


gives :

res  = -600
res  = 429496130

with msec, the previous code would catch the overflow, now it overflows 
silently.

untested, but maybe:
	if (result.uint_32 > INT_MAX / HZ)
		goto out_of_range;

?

CJ


> 
> Acked-by: Ilya Dryomov <idryomov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Easwar Hariharan <eahariha-1pm0nblsJy7Jp67UH1NAhkEOCMrvLtNR@public.gmane.org>
> ---
>   drivers/block/rbd.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index faafd7ff43d6ef53110ab3663cc7ac322214cc8c..41207133e21e9203192adf3b92390818e8fa5a58 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -108,7 +108,7 @@ static int atomic_dec_return_safe(atomic_t *v)
>   #define RBD_OBJ_PREFIX_LEN_MAX	64
>   
>   #define RBD_NOTIFY_TIMEOUT	5	/* seconds */
> -#define RBD_RETRY_DELAY		msecs_to_jiffies(1000)
> +#define RBD_RETRY_DELAY		secs_to_jiffies(1)
>   
>   /* Feature bits */
>   
> @@ -4162,7 +4162,7 @@ static void rbd_acquire_lock(struct work_struct *work)
>   		dout("%s rbd_dev %p requeuing lock_dwork\n", __func__,
>   		     rbd_dev);
>   		mod_delayed_work(rbd_dev->task_wq, &rbd_dev->lock_dwork,
> -		    msecs_to_jiffies(2 * RBD_NOTIFY_TIMEOUT * MSEC_PER_SEC));
> +		    secs_to_jiffies(2 * RBD_NOTIFY_TIMEOUT));
>   	}
>   }
>   
> @@ -6283,9 +6283,7 @@ static int rbd_parse_param(struct fs_parameter *param,
>   		break;
>   	case Opt_lock_timeout:
>   		/* 0 is "wait forever" (i.e. infinite timeout) */
> -		if (result.uint_32 > INT_MAX / 1000)
> -			goto out_of_range;
> -		opt->lock_timeout = msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->lock_timeout = secs_to_jiffies(result.uint_32);
>   		break;
>   	case Opt_pool_ns:
>   		kfree(pctx->spec->pool_ns);
> 


