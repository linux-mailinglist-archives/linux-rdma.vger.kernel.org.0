Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75EB1DAB17
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 08:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgETGyr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 02:54:47 -0400
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com ([40.107.93.81]:62657
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725998AbgETGyq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 May 2020 02:54:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TovAAStFr6dQ37cf/MQD+bY7blxvs/dUFrClVDj58fM/LXWE+2+V1U56eqk4HnE5W52d1YEyG39k57Gk6IXNXYZZxcxMUMmFhCRF3L8CA1j1nW/rELLBhlskP+T4YEf9tb2q8PvjsY4UFMjKA8foVo8j6kEPcjBQF2tdHw/h28eY9pJ/QTLbwGFL8mAMnWo2GQfWkhwq7IYZnetgK1eSrWEa4Ose6WwfBtPQ7lfj8dzQE9QTQK7JY9oH5SQloGct9HCvLFoGawZy/cdu/yh8YStIl2dw6xgYqkfiT2AiU0Ox10v4zhRCl8WzDT515X7IahgrJT+YCOSHOehwWG8EBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdaCuSPmEN2mL3/eYXoPsSxKryrFjyMCDnrvwYZBEME=;
 b=ZZAEsLSs9LVeeqr0P4zT8UoIdlOUuYnVPniuIUCJTnfDXMPoxJe0RfbyiCEZ9VOZ8eBITOrD8PbHMTsOASg6NQO2n8QHK+yPo7vTH/oKRxMtv4WaQXwwTe5KmCVFJATAsANu6iUw+HHq5KSmvzPZFlUMgHHmt5+5wJWvj3UAs1QK2iyfqB0ERLAa+wuE8H2yLJ6hAaMwPMpxSluChPRD8/L5QD5iDug2WALm1GuS46X0sKWGb02tYBuyzybG1Bwu/CJeaK9iKu+7zcENqI4gO3FbT0NL3+Cp3aEg8MpitnmEYoLvugEQ9zd4pWOB15BKJ22SO2BfS1t9OuEHo00gYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdaCuSPmEN2mL3/eYXoPsSxKryrFjyMCDnrvwYZBEME=;
 b=ZdLONIhUxC0l8fYW5/3KrPj36fYxyozyAWkrv/CHW5JlGIy4RjLM5B/r3tI/b8KbHswqEEZb4MvZxMvDg+Ze93QXJLw1RlqGuE+lxTQBHnWjPr1tSK+dMJ64zPUSiXysnUgJX073gMvsJIR0sYA7yrf00rjOe9ShCHNJrr9QYj4=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3260.namprd12.prod.outlook.com (2603:10b6:5:183::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Wed, 20 May
 2020 06:54:43 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 06:54:43 +0000
Subject: Re: [PATCH] dma-fence: add might_sleep annotation to _wait()
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20200519132756.682888-1-daniel.vetter@ffwll.ch>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <be86b73c-2fb3-a6c0-5a12-004af051210f@amd.com>
Date:   Wed, 20 May 2020 08:54:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200519132756.682888-1-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::22) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR01CA0081.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 06:54:40 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3edeaee0-4091-4114-3eaf-08d7fc8aacd2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3260EEC5E50B9A746401F5E983B60@DM6PR12MB3260.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wdMPcZpomRbJjgCjDgCCUUZya90n7J1+9UkWattp/9IEasATIGqpxoSqxQoeit81uNco0lHslCBaGSB7cK3RKiI18D/vtolrL7Fpd77R1VtsqK3Jg+jepvrL4M5kzIXZ6i1Vq/XVLl0F8z/eg4WTuMInnCs4IN6Yq9f8uEu9LVrJma/0Vi8ByfDNHEqAGfAR3UwG33Q//7pG86y8Ph/bJJHWbEr4WbGM4O6IkPAZ2PhtGdfLcoLMIBFcCaRbEcpxH6gAJKW+2OlA8Mwg+WiUpE6/mHXHObuIGfn+L790APf7Ww+bydhDT0kGjUF2NCx5FTT8Mj/9r+U58LR4muBCynl62DU0UVrXAHcvwtvI4YBadIHH9EpAli1VxgJvmcBoV40fiWiAnIl2vGVN1hwyyWMXNsn1K7y3K+5KnQsvMS+SihdljPyoP/P0VWcyp2C7WRbv0sUKiwkOf8cLxZwwf1seX2ya4qEote9GYgqCd+V6R8sriUMIX3rfuJCsuJZC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(86362001)(66574014)(66556008)(31696002)(66946007)(36756003)(54906003)(110136005)(8936002)(8676002)(2616005)(66476007)(316002)(478600001)(5660300002)(6666004)(31686004)(52116002)(6486002)(2906002)(4326008)(16526019)(7416002)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /V/rnfUwvEvDmZLV6qlOAhuH5H1zplobp8r10KdpsMacdqzT5BPNffDK2iJnJWxuBkh6t4+zrCADfkH+0KZMGvR/hSatCm6qK98Pk4sGeScWGo2OWXvvPf+DW1T1s7hAVimWUJpi9wF+37c3x4EjT9q5R1KOxIAAZ23GeylDig6nS925R1qE3ZhzV5boCS1Hsgg4JU8jdasJNWZU/pBx7MmhI1fbVcFNbO2pKGCNcsqnlmKwZ63QDPW/keKAhsmkUb/1sm3UYCPfi0gw1E6QQfEARkUk3Q8xeAk7zP+Ja0QZXEuXT6WrfvUKl1xQCrlIS/OKA0OcHGL/sKqqFUAUXMIFpWdKFbom867K2JM0XCJnbpHwESb2oJsxzNTeHrC6HwDA20vVg6dpTMl7Ln+75rnTrJPJW7JG4Glu242z+YJ6F/ubQXPTOiJLH5220tKaieWkP555dgqrZNsO/gtDBD9mmslWMk962nME5rUTve1svCA29ofYSz4Wqnra3YOp4JvGOTGX7nYACmBcdQ22qZ1C1ObBs+ZZOFCPZ9qldljC5F+nmyrQiTYu4njytz/H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edeaee0-4091-4114-3eaf-08d7fc8aacd2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 06:54:43.3172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2iG+D4zLjAeN5gfBpiIKu8PsRzrVGpBLaDRcRCsKqRRuP+jS5A/aJ/qjMEeReL+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3260
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 19.05.20 um 15:27 schrieb Daniel Vetter:
> Do it uncontionally, there's a separate peek function with
> dma_fence_is_signalled() which can be called from atomic context.
>
> v2: Consensus calls for an unconditional might_sleep (Chris,
> Christian)
>
> Full audit:
> - dma-fence.h: Uses MAX_SCHEDULE_TIMOUT, good chance this sleeps
> - dma-resv.c: Timeout always at least 1
> - st-dma-fence.c: Save to sleep in testcases
> - amdgpu_cs.c: Both callers are for variants of the wait ioctl
> - amdgpu_device.c: Two callers in vram recover code, both right next
>    to mutex_lock.
> - amdgpu_vm.c: Use in the vm_wait ioctl, next to _reserve/unreserve
> - remaining functions in amdgpu: All for test_ib implementations for
>    various engines, caller for that looks all safe (debugfs, driver
>    load, reset)
> - etnaviv: another wait ioctl
> - habanalabs: another wait ioctl
> - nouveau_fence.c: hardcoded 15*HZ ... glorious
> - nouveau_gem.c: hardcoded 2*HZ ... so not even super consistent, but
>    this one does have a WARN_ON :-/ At least this one is only a
>    fallback path for when kmalloc fails. Maybe this should be put onto
>    some worker list instead, instead of a work per unamp ...
> - i915/selftests: Hardecoded HZ / 4 or HZ / 8
> - i915/gt/selftests: Going up the callchain looks safe looking at
>    nearby callers
> - i915/gt/intel_gt_requests.c. Wrapped in a mutex_lock
> - i915/gem_i915_gem_wait.c: The i915-version which is called instead
>    for i915 fences already has a might_sleep() annotation, so all good
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: "VMware Graphics" <linux-graphics-maintainer@vmware.com>
> Cc: Oded Gabbay <oded.gabbay@gmail.com>
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> Cc: linux-rdma@vger.kernel.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/dma-buf/dma-fence.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 90edf2b281b0..656e9ac2d028 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -208,6 +208,8 @@ dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
>   	if (WARN_ON(timeout < 0))
>   		return -EINVAL;
>   
> +	might_sleep();
> +
>   	trace_dma_fence_wait_start(fence);
>   	if (fence->ops->wait)
>   		ret = fence->ops->wait(fence, intr, timeout);

