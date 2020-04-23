Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B701B5809
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 11:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgDWJWg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 05:22:36 -0400
Received: from mail-eopbgr30058.outbound.protection.outlook.com ([40.107.3.58]:8544
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbgDWJWg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 05:22:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5M+MgsUu/budCfAjNUwrpxXLb6ZgahxZbxZwetLwzWDnMV2dg/Gyf3ZFqK5sza4QxE+pmSZ/320/3ngwwU6KHTiN1CcBZhzbSQcEx4SOaKF2WFq5Wix5ZsEDTqZq2w+ly9NLmPLLCGVEigfFAH7BWE/yTEIJ3/vNb7AB71xyTtIggIX4XeQ6diYfeKV1SJN3Rb7+cF24h0kk3QsBA2y4LLoIQB95+znfihqPC3kZN5bMIxTpdtU0QK3rkKYfmkKykBPmLHkXKmujkPWP8jfE9XH6PdLjDwJAbIYTM5I8Y9npEGMiVD/B1XZZtR9oFkcrez5pEZr1y+dXf12IRkCSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJuarDSoufJgjMXcgf5FRRL/DBmwL3iA0n9t9GJP2jE=;
 b=EhyZlLr7te129BBNhKSFJACuHj/H1tlojy91SiQU/i5A+VLbgBisK3OWnhzrs6cayJNlWAI0BvOX1gNnNKvGaloHzeCXPssLPtqEi/WL5IMNxpbvV9680JH7zIO7Nt88RZTREJ+4dTBi2gjroKzJTrTlOAuZPpeLvFRdL6Qayy80TpTGvxW4QS2opW5Cxw0cw2pYh9lxakIh8I6aPgmWVzjxVssJTQgx/y6xlXbBaRm9xjxBq88Ti4AoWkOT41hPioN7NBFmKrebw18E/Xrxc1jrwtZrT3vQTUgKU1sJyWBotwBODSaql0vDZAGtUIOY/3uSySEiHlqrqwEiCcjfcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJuarDSoufJgjMXcgf5FRRL/DBmwL3iA0n9t9GJP2jE=;
 b=LmGabd5iywADn8LKIJG1Y/UTXAz3mf8VqCyQqk9g6QNKB2rrQ1sUU2yUyeJYaxWOg6gtcePmdu7Odz3jL1OqiyR+Oj5KeYZdWjWkb+XXhuC1ZGB08CjIsx4Kz4qeFX5HWNdv2eCvlNTSioZBf+zHGUMt3QjXhJVRXJQlF40giow=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB5059.eurprd05.prod.outlook.com (2603:10a6:208:c6::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 09:22:32 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 09:22:32 +0000
Subject: Re: [PATCH 08/17] nvme-rdma: add metadata/T10-PI support
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org,
        sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
        linux-rdma@vger.kernel.org, idanb@mellanox.com, axboe@kernel.dk,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-10-maxg@mellanox.com> <20200421122030.GI26432@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <688ec4ba-78e8-0ba3-9ee9-3c19b3e7b0c6@mellanox.com>
Date:   Thu, 23 Apr 2020 12:22:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200421122030.GI26432@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::22) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (217.132.177.164) by FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 09:22:30 +0000
X-Originating-IP: [217.132.177.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 74235d15-c595-4c01-4201-08d7e767d9cb
X-MS-TrafficTypeDiagnostic: AM0PR05MB5059:|AM0PR05MB5059:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB50596042CFA380FAECD2E56FB6D30@AM0PR05MB5059.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(8676002)(186003)(66946007)(66556008)(16526019)(107886003)(6486002)(6916009)(956004)(66476007)(86362001)(52116002)(53546011)(4326008)(31696002)(2616005)(26005)(31686004)(8936002)(2906002)(478600001)(36756003)(81156014)(5660300002)(16576012)(316002)(6666004);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DOz410RHSVd8hCDHKUhrmP65xI0zZ07SHlKOGE4qEO56MBuqJOL7VuXMNIGBMWJKVdSP9ULTqpt+LJ10weSCZ5iOqkdjLQzCQDgeuyWRn+LI+XMY1mRKBjFpBthclU4QQFiDaRAZYi5gLa3FgFJ72GG5lgeAiMFl6c1eo5r4N33exy/8bGIQBP4NkepNfphcQAeGeaUPCk5xiWXDNm5QV98mcKbcSud2FABErrH4i6pvj7XbC+SeEzX30R4vD6D4TKSVFLZqsT/GPxe5tny5H9qu1FRelDgyPxrXkh5mc2rvxays25fjHm9KWGFl6+cpag+k+6SI/ILdWwqr0TCGfUl8edaP53nm1kXLZnYqiFIDEDB/t6jjmOHg6mYXkAVXdLhTlUtxTYr4UtGU/U8iwTUUUDObcqdCmCfn3LnWsNUI0GJX71VUxYAy26nWseI5
X-MS-Exchange-AntiSpam-MessageData: MYMqaE8oYQm2S+8xA8INIE0b2MyWVHJmLGiXJ/XJn7j/ZR7vtFF7I+N1kRV/hcV2rBIKOki42yhv2vOgQVHs5mvT1w8J9VpNOyRQTOWhoCKXG+SP1Fs41TYK68iEFkjDF7El/LxI501xTwtLqR7Dn2FQJc2xPqD7VOpXp/wn9uLmJfess30+bWNNUvdQmpWlAZuyFdmXVguXh+gfbnhiNXTU+qka0rU3qPH8at5aidITrqqzYfJS7mAu4+02kpGTi8ZR/ix2oC+NMwVMa5voiqa6gFSHgE173uzrKhNmriWW6/FqKe24FOMjLoOORzp85uq+/YpsxGyOqrw4CZj/xTUU4+APSPm5NUTzC+g4cNdXX7AbmuxxV3JUQ6RshyJR318q6f/ozLT/uJzomV7rKm6hVHfig9knaIyslk2f2ARq9hAd2jh5YXIGeWnqBu1Yz6kO9GoAYjlqWY/x0vXhqd18C4qvcKYDslRGu1ngMqXvx1bil4SstsXCkOfD7xxt4vd/UGHeWmReOBhjnC1goDcREAdCyMjPwjZJFRpvuVrWjnDXjTtcdsjBXPHDmplvulEPiNqHGHPMbeVvyBADhGiHFhy1X8ZZws0QKsaaRiQCFsffMipb8OMNTaV1W80iPVujckUe7CrbttnxPpsl4OkgF3ZDT7qVFariNkugk7GKusBM2y2TUWu7lFG9QOEmmC3fx7+wo5pNDP6FYnjfkaM2NFudnyqVUsVgHccQBiHv0HflvXJ70gmKoi+hIywXKWDMcvtC/WoJjaMS1SDAF51dNtowPuhh7/CSagPkgnWNggGnbcyEiYHrDBXHM07S
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74235d15-c595-4c01-4201-08d7e767d9cb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 09:22:31.9947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWu++Q6O388pJvhltdLe/QHWwTenKoOyeo+POWMpTMHxcBa24qr6Qt0GZbMXdCwC0Cu8I5unrKMru13WWWCv7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5059
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 4/21/2020 3:20 PM, Christoph Hellwig wrote:
> On Fri, Mar 27, 2020 at 08:15:36PM +0300, Max Gurtovoy wrote:
>> For capable HCAs (e.g. ConnectX-5/ConnectX-6) this will allow end-to-end
>> protection information passthrough and validation for NVMe over RDMA
>> transport. Metadata offload support was implemented over the new RDMA
>> signature verbs API and it is enabled per controller by using nvme-cli.
>>
>> usage example:
>> nvme connect --pi_enable --transport=rdma --traddr=10.0.1.1 --nqn=test-nvme
>>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
>> ---
>>   drivers/nvme/host/rdma.c | 330 ++++++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 296 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index e38f8f7..23cc77e 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -67,6 +67,9 @@ struct nvme_rdma_request {
>>   	struct ib_cqe		reg_cqe;
>>   	struct nvme_rdma_queue  *queue;
>>   	struct nvme_rdma_sgl	data_sgl;
>> +	/* Metadata (T10-PI) support */
>> +	struct nvme_rdma_sgl	*md_sgl;
>> +	bool			use_md;
> Do we need a use_md flag vs just using md_sgl as a boolean and/or
> using blk_integrity_rq?

md_sgl will be used if we'll get a blk request with blk_integrity 
(memory domain).

use_md will be responsible for wire domain.

so instead of this bool we can check in any place (after prev commit 
changes):

"

if (queue->pi_support && nvme_ns_has_pi(ns))
                 req->use_md = c.common.opcode == nvme_cmd_write ||
                               c.common.opcode == nvme_cmd_read;

"

And this is less readable IMO.

>
>>   enum nvme_rdma_queue_flags {
>> @@ -88,6 +91,7 @@ struct nvme_rdma_queue {
>>   	struct rdma_cm_id	*cm_id;
>>   	int			cm_error;
>>   	struct completion	cm_done;
>> +	bool			pi_support;
> Why do we need this on a per-queue basis vs always checking the
> controller?

To distinguish between admin and IO queues. I don't want to allocate PI 
resources on admin queues and prefer not checking (idx && 
ctrl->pi_support) every time.


>
>> +	u32 max_page_list_len =
>> +		pi_support ? ibdev->attrs.max_pi_fast_reg_page_list_len :
>> +			     ibdev->attrs.max_fast_reg_page_list_len;
>> +
>> +	return min_t(u32, NVME_RDMA_MAX_SEGMENTS, max_page_list_len - 1);
> Can you use a good old if / else here?

sure.


>> +#ifdef CONFIG_BLK_DEV_INTEGRITY
>> +static void nvme_rdma_set_sig_domain(struct blk_integrity *bi,
>> +		struct nvme_command *cmd, struct ib_sig_domain *domain,
>> +		u16 control)
>>   {
>> +	domain->sig_type = IB_SIG_TYPE_T10_DIF;
>> +	domain->sig.dif.bg_type = IB_T10DIF_CRC;
>> +	domain->sig.dif.pi_interval = 1 << bi->interval_exp;
>> +	domain->sig.dif.ref_tag = le32_to_cpu(cmd->rw.reftag);
>>   
>>   	/*
>> +	 * At the moment we hard code those, but in the future
>> +	 * we will take them from cmd.
> I don't understand this comment.  Also it doesn't use up all 80 chars.

It's a copy&paste from iSER.

I'll remove it.


>
>
>> +static void nvme_rdma_set_sig_attrs(struct blk_integrity *bi,
>> +		struct nvme_command *cmd, struct ib_sig_attrs *sig_attrs)
>> +{
>> +	u16 control = le16_to_cpu(cmd->rw.control);
>> +
>> +	WARN_ON(bi == NULL);
> I think this WARN_ON is pointless, as we'll get a NULL pointer derference
> a little later anyway.

I'll remove it.


>> +mr_put:
>> +	if (req->use_md)
>> +		ib_mr_pool_put(queue->qp, &queue->qp->sig_mrs, req->mr);
>> +	else
>> +		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->mr);
> I've seen this patterns a few times, maybe a little helper to return
> the right mr pool for a request?

yes I'll add:

static void nvme_rdma_mr_pool_put(struct ib_qp *qp,
                 struct nvme_rdma_request *req)
{
         if (req->use_md)
                 ib_mr_pool_put(qp, &qp->sig_mrs, req->mr);
         else
                 ib_mr_pool_put(qp, &qp->rdma_mrs, req->mr);

         req->mr = NULL;
}



>> +	if (blk_integrity_rq(rq)) {
>> +		memset(req->md_sgl, 0, sizeof(struct nvme_rdma_sgl));
> Why do we need this memset?

just good practice we took from drivers/scsi/scsi_lib.c.

It's not a must and I can remove it if needed and test it.


