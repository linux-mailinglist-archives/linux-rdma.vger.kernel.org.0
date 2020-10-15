Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E62F28F6D0
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Oct 2020 18:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390045AbgJOQbx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Oct 2020 12:31:53 -0400
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com ([40.107.93.84]:54464
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390013AbgJOQbx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Oct 2020 12:31:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbuRt07AT1qcA9xfIknZ0nz8vr/3dJEi04W7hGdPnc9gRZ9yB15LWxfLFvqBZrI5bS/oaZRKYjaimVHsJXkO5DelUivhC6v42q5q5VVpWxo5K51gqBJMn85j9H4SnyLcO5Qqp3I45n2KRJc/0iT/834pCl0zFdCS8YGweS4XVJzs0N4gwqTAYt7V+deGE/wBKm8T590VKOKYj8cNDLkdPtrDfkkwsaNi1wqMyFZC7l7M+JAF4I9qvwtAanP+UhAknxQu3r7yIZ6eWANnlxQtkCu/uJ2eShbRoAyFEjEjfabANr8E5tJ04PS+ieTx8cXGgpwR8d9RULrj3adwpl4y5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4ktphmCmhn5MbN64FLj978WmpHUMi7g09O453FLsAs=;
 b=eY0iZ1dktlDb8FVLRc5pm7TkG0FfjNVjnxkhCVK1muWKvfqnHAXRG6uBLL3WI2IkF8uCYd+X3zXYWK79QeVXH7YXVxBi4Q5BE6AXUGFxsY4EFbN02zGH+uU16aIxQEQU8KZHmodUzHVodkUtOlROzPegjC+wFxeWCL95Z9H8K7fi89T468anGZuRTDKaNS7YdkBjq2n7v02a30caAUFKRMsEiJOy1I77OQu3ZdWX2Fa5lhy/pTUuoYcldd/f5eogmk2OJh6xr95xH6joBv97242AgC7R91D4oE0nRaPBVNnyCUWfj47xEkoOtUNYgAgByyCirrUDX5KM6Fbq5s0wZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4ktphmCmhn5MbN64FLj978WmpHUMi7g09O453FLsAs=;
 b=StHOjFyTHsV2iqzMXpVNyZw8nzJyozjKWf6R8t/Vf3dUleA83GPp647QE25h0L9qZ55jJ8gDYEFu1v6aBXAu1P4TLmkIkmKAbDvL6kKGNErX1X7s0b97AZvMNm7YvaJPVJhVWemutJTyTkSsQ3JSDKEstqXh3JiX7ZRPd1kDwuU=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4797.namprd12.prod.outlook.com (2603:10b6:208:a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Thu, 15 Oct
 2020 16:31:49 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3477.021; Thu, 15 Oct 2020
 16:31:49 +0000
Subject: Re: [PATCH v4 5/5] dma-buf: Clarify that dma-buf sg lists are page
 aligned
To:     Daniel Vetter <daniel@ffwll.ch>,
        Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <1602692161-107096-1-git-send-email-jianxin.xiong@intel.com>
 <20201015160344.GA401619@phenom.ffwll.local>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5d7609d0-5548-eab7-b170-c420f6cb3de3@amd.com>
Date:   Thu, 15 Oct 2020 18:31:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201015160344.GA401619@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [46.114.105.76]
X-ClientProxiedBy: AM4PR07CA0018.eurprd07.prod.outlook.com
 (2603:10a6:205:1::31) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.137.56] (46.114.105.76) by AM4PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:205:1::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.9 via Frontend Transport; Thu, 15 Oct 2020 16:31:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3a2a3b9a-98e2-4959-fe66-08d87127d088
X-MS-TrafficTypeDiagnostic: MN2PR12MB4797:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4797F2FBB0D9B4947B8A63D583020@MN2PR12MB4797.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VCXjbZPPrmKsrbVgIdvDiX5hqooncuVngQi1u7NXrpSZIxpLpz3xwJiPoOX+eX/F3pwk/l+wUlYlG/hm6scOHs4/HtwS49DLWAyS+zh9g/fzMfILqhK8/BCLbzZq2BEe50etXribafM3PqpqbK9TYSTqQmKQI1VsrYr7DwGvOZQk8dnwroU0qRBq6VAKNyev13dqLB7MJ7kAY1vut3YtqD/K46UIEZQVarhukN6V9hmYRkOId8/lybZe5+3jkc86oMQRyPRbEbYCvcK436WPTUM1FEthZVh04bkRNaVwNeOf+wFyGnOsyjIhgjMQsA2rFyIQPhTCjQHVQolx+RtQJmFo5eeY+wm0F6XdnobR1n2aQ1WlMYho6fV3jGClvD7eFiASSTGrZfSYPSBnDFwy3Pc+8YgO//W6r+vQijApTKCPCP5ojldwRTZdwcSxN4qFntOW1OOkNN+fosWZQDDeng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(66574015)(31696002)(5660300002)(6486002)(83380400001)(86362001)(66556008)(66946007)(6666004)(66476007)(36756003)(26005)(54906003)(8676002)(31686004)(16526019)(45080400002)(316002)(956004)(16576012)(52116002)(186003)(110136005)(2616005)(34490700002)(2906002)(4326008)(7416002)(478600001)(966005)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rM8l8uf/Yd0cqJJo6bI4ltHpBvsW8cqk4R1HOOsr3JLc+IKtTtHZ+K/PK3XaLh9eU8+Q2dW71+G3hWvReMHLDm2epNCKLpl3TaV20CvhEBWF9juZKbtymB7XsM+/igNOPD20mtpwE15oQEXkMEOuwKFDFtVg7J6Ip9ftd59BERJgOyXkShlOGqb2w4ymIq1Ds0NtpGzB67Dt0TshJKhq7t0fBdlj1iiaJf+/Wm0rgNDTjX6jyUBKrZzAbwDe0/xQ2dCQ4YRmDyd7QdmZ+6C7S4IVXOyeAklv4gg5+MoxaT/aDSkLwEbLyGJaZEFbQFf/Z7GURXcoJNmrse1kSguD3+u5GYck6ofNYuIbgtklUEE1EeVFf8an+4+9S7F0u98FXwCn24yBXS0TuNdktzQowZrSc8FVlMp+iCAsl/0UJP6WKjJaw9ymWQvyx2i/gESDS6aSvwrb7iU6LIXgJt8Zkm4FKHnkPivN6cht0RfghYeuFbCncDbgyqfsMAoh6fzcLSxsmLxDqA2T0K1s2xbuI7ZPEO4/M+jS9W0Kwfs3mLQJGoEHnk8+COyxK3shnsCU2NNZjkRMHc0pj9rPbXbLXDoIhDuYLc9QZJ4G3G7JinHBCeKESfujs6T6FjS3UrIos3It9sgOJx6IpnCs+GFlRg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2a3b9a-98e2-4959-fe66-08d87127d088
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 16:31:49.3255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6v0hs5bed+SYOHAVxkakmwVOlUtEy+drvRxqlHfYNWv6zV9mExj5bnIHSD89P5q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4797
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 15.10.20 um 18:03 schrieb Daniel Vetter:
> On Wed, Oct 14, 2020 at 09:16:01AM -0700, Jianxin Xiong wrote:
>> The dma-buf API have been used under the assumption that the sg lists
>> returned from dma_buf_map_attachment() are fully page aligned. Lots of
>> stuff can break otherwise all over the place. Clarify this in the
>> documentation and add a check when DMA API debug is enabled.
>>
>> Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> lgtm, thanks for creating this and giving it a spin.
>
> I'll queue this up in drm-misc-next for 5.11, should show up in linux-next
> after the merge window is closed.

Thanks, I'm currently without landline internet and need to rely on my 
mobile.

Christian.

>
> Cheers, Daniel
>
>> ---
>>   drivers/dma-buf/dma-buf.c | 21 +++++++++++++++++++++
>>   include/linux/dma-buf.h   |  3 ++-
>>   2 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>> index 844967f..7309c83 100644
>> --- a/drivers/dma-buf/dma-buf.c
>> +++ b/drivers/dma-buf/dma-buf.c
>> @@ -851,6 +851,9 @@ void dma_buf_unpin(struct dma_buf_attachment *attach)
>>    * Returns sg_table containing the scatterlist to be returned; returns ERR_PTR
>>    * on error. May return -EINTR if it is interrupted by a signal.
>>    *
>> + * On success, the DMA addresses and lengths in the returned scatterlist are
>> + * PAGE_SIZE aligned.
>> + *
>>    * A mapping must be unmapped by using dma_buf_unmap_attachment(). Note that
>>    * the underlying backing storage is pinned for as long as a mapping exists,
>>    * therefore users/importers should not hold onto a mapping for undue amounts of
>> @@ -904,6 +907,24 @@ struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *attach,
>>   		attach->dir = direction;
>>   	}
>>   
>> +#ifdef CONFIG_DMA_API_DEBUG
>> +	{
>> +		struct scatterlist *sg;
>> +		u64 addr;
>> +		int len;
>> +		int i;
>> +
>> +		for_each_sgtable_dma_sg(sg_table, sg, i) {
>> +			addr = sg_dma_address(sg);
>> +			len = sg_dma_len(sg);
>> +			if (!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(len)) {
>> +				pr_debug("%s: addr %llx or len %x is not page aligned!\n",
>> +					 __func__, addr, len);
>> +			}
>> +		}
>> +	}
>> +#endif /* CONFIG_DMA_API_DEBUG */
>> +
>>   	return sg_table;
>>   }
>>   EXPORT_SYMBOL_GPL(dma_buf_map_attachment);
>> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
>> index a2ca294e..4a5fa70 100644
>> --- a/include/linux/dma-buf.h
>> +++ b/include/linux/dma-buf.h
>> @@ -145,7 +145,8 @@ struct dma_buf_ops {
>>   	 *
>>   	 * A &sg_table scatter list of or the backing storage of the DMA buffer,
>>   	 * already mapped into the device address space of the &device attached
>> -	 * with the provided &dma_buf_attachment.
>> +	 * with the provided &dma_buf_attachment. The addresses and lengths in
>> +	 * the scatter list are PAGE_SIZE aligned.
>>   	 *
>>   	 * On failure, returns a negative error value wrapped into a pointer.
>>   	 * May also return -EINTR when a signal was received while being
>> -- 
>> 1.8.3.1
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C58ee8712041e4e742fe408d87123e970%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637383746351346603%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=EwAEVcJa6gboHMEQ6XUymC%2BtjFoWd0wl8YUyzdnV5N8%3D&amp;reserved=0

