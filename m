Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592E51B8EAB
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2020 12:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgDZKEx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Apr 2020 06:04:53 -0400
Received: from mail-am6eur05on2088.outbound.protection.outlook.com ([40.107.22.88]:12736
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726118AbgDZKEw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Apr 2020 06:04:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/Ira7dE7Vm1MR438na6mDh1DhseAuyVVk6SXbXtlC0sHrTdoJA9huU8HVuQbBOg52H+ErF/b3YKrgzlvUUmVDgjkwsnXPur8a6JZ/GS6xuA/ZKNRxwAKTrV9CjPPLlGMR38oRQpXiIG4PZKLfuWYYNGC4fjrfbhG1dRwdGNrHOZTQe6/KiFnk+EJ52Ah9Xks5ap0dltB1t2yMOSOZI+I/o6gpg/s5MxiiVUekSusWsCYQFy7SK/CCRtkGWX+epp3JHg9L4+KNDx1yGk8iSWv4E5vnrYD1gyLHLrFkSKyaDvt4H88ahcde+iutnKyNMLPfwnUDgGuSaX5/IulL5s3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lt63y3Q6HUJigOhfm4SAdI+YU9zMghFP8U21LwNNvNs=;
 b=Dw5RUZt3UaalaTXrTB+yERXQPgKBxytJ1B1QsHW5MGtRwcK9W3F1DIafqx2jhjZE7ftTjYYnTmrEFsh++rXqHDPZhI9/i3CKRIiuqOXsbwqQ/R4t1q7cflhEgEE90G6UKYgFEBtiHP2XX1gWn/ZccNUkpXix7oe29rMorRzzUSBC1G3CoN2kK+Rg+d71A7PUMuyqXYY788SJEBqGvB6m/6nWQUcrrHSIxLLa/aW9cF97DDjblzYgaAMlxktoV/uARy2xm97AMH7ENBoq0S5W8cmaMK8Yk4hwBsRAdfj3edQwYQ8k60yobLv9PSGsFi/4/z0rY3U8eQgNMyOJ5ICG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lt63y3Q6HUJigOhfm4SAdI+YU9zMghFP8U21LwNNvNs=;
 b=qyvQPSyrdcErGZDEsZG1kpvN6m+CFZVef67zGSqGJYWzCpcSDTKnbrMim8kFZP1/xMDp5dJh0Ob9DME/9TuO7SXOBXeYnzvTQIVGdn8cIN1hWUDmLnB9gsZOEoyY7YP75pWZbwzNaNpHeNt2xvYQLEanHtGFmWJLeiOebBuGHSk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB6002.eurprd05.prod.outlook.com (2603:10a6:208:129::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sun, 26 Apr
 2020 10:04:48 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 10:04:48 +0000
Subject: Re: [PATCH 08/17] nvme-rdma: add metadata/T10-PI support
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org,
        sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
        linux-rdma@vger.kernel.org, idanb@mellanox.com, axboe@kernel.dk,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-10-maxg@mellanox.com> <20200421122030.GI26432@lst.de>
 <688ec4ba-78e8-0ba3-9ee9-3c19b3e7b0c6@mellanox.com>
 <20200424070930.GC24059@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <9e678a4b-814e-94c2-6405-51d5030839dd@mellanox.com>
Date:   Sun, 26 Apr 2020 13:04:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200424070930.GC24059@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR05CA0079.eurprd05.prod.outlook.com
 (2603:10a6:208:136::19) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.7] (217.132.59.243) by AM0PR05CA0079.eurprd05.prod.outlook.com (2603:10a6:208:136::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Sun, 26 Apr 2020 10:04:46 +0000
X-Originating-IP: [217.132.59.243]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 19e9a858-cee1-4787-9d53-08d7e9c940ca
X-MS-TrafficTypeDiagnostic: AM0PR05MB6002:|AM0PR05MB6002:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB6002719915D6CF474F91FFF3B6AE0@AM0PR05MB6002.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03853D523D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(107886003)(6486002)(8936002)(8676002)(186003)(81156014)(86362001)(5660300002)(16576012)(316002)(2616005)(956004)(36756003)(31696002)(52116002)(4326008)(16526019)(53546011)(26005)(31686004)(2906002)(6916009)(66946007)(66556008)(66476007)(478600001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FoKC+Vd2z+elrWj0uwanxsa8Pw+n2pitQQd2bQiIWPCJirfVpe/MhkHsOuoZ5cECbzNzhsOa6V+q9rcqkdBDB7pyu26Dhz0JT1CZbrQBF1Zt0OCd3Ei0LlfuqAj0MQNQoyNqkR2c9XXRYOQ8cTR+oTSSsFefdwnewKY6PFovuGa8NZnvgV3TaBxt5KbOdL9YWWehhMLlds68gBY1t1MD36L2PHAMZW0VUqDHOdThv3TQr5rme4j7D5oiw6/dWAcuIQ+3aiWBoKY/K157UXuHkxl6+OVc+iojrtO5kPdJExx7MRWgVp5ktn8j4YqqE8FqkBhxc+EzbqNbsKONmmm83xwiRVcRDjFKx716FiHPYtdD4u5L1FwaNlAJmb9PoHJBjokhqISn/WbNcfElqyjEWlYxq2g1T+hfi1YIm5+cYYHW0FdVj0HgfF5RjvUr+I1v
X-MS-Exchange-AntiSpam-MessageData: Dv4WZmIlsZKVCN3+cKEMvW0TI425DudO/K5QwqgwVd4XLG+D/05rlExe5lF2/UZilpxrIoxbf9v5Y5EHMbL5YQRH5UN/8FAlneEu7pcQeYCvo5QdQgPQgBPURTfkwIK9lSJkcQ/Sf3rYGXpe2v92byJWbszMHfXQmZDIjz/vScM1oGQ2vKbtXISTm1Nqm5b4wYJI4OW5KCvAEI6qABSUZFW/vJKIhan5Phb6wiOd1C9bBdtj2ReYtu5vXjDVcRTQ0rvtzaEJGYnTo+Q+uvZs6N+LsdRUbl1okOnKYPw2Kj5PAo2B7TgcSrS78RYka/mBh5xuxtNGUK7nMOGNB9XbYdxMMwbMNIqyGTqexYWekGrRGEeK92PpcO5LEXoKoXgHkC7Ql7JUktxMXGuvrWEO0/oMpckBKUSusJ2HIFGDBXLrnzmhvUf/bAmlFgeXKCOAcnY0xQ17NYto90mZyzsEp4oq7Sd+XQzfyng4UevmLYC4WAq3cAoU078vUS3ZwNlGj1rrqANMOQnKU4GGjzvBfNJn1V8WFr2fmdy0pBEYJySFL8AwjutZRcZk4vexituoYvJY8N169Fc9c8xSpIG2+732JQVRd9gR+gA81YqpKTiqNTvZCvcNEnMpd4RGel3nsdkaKVDhA2Umad0b9tfZbg1ztF9QPPMp3H/DUjhILMxbzOO7dkQpzch32/Znfhc4qd4/7zM2W17TKVO8+84LHaOZdJ3hN5KIvtcCfO0If8T5WhqqPHv41CxsBHE4fyIAWHowUjaKJbMTZ1SwWVReKrEU63ZBNxn5pQpmd900VLk=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e9a858-cee1-4787-9d53-08d7e9c940ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 10:04:48.3401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pl6k+lP6I+DPoRq02qy9ipseR+4xz8SLh9obuFVxDvAixYy65mUK6WRh0HuXWiBDeOOEUk2JDbF4tf9aECV4KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6002
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 4/24/2020 10:09 AM, Christoph Hellwig wrote:
> On Thu, Apr 23, 2020 at 12:22:27PM +0300, Max Gurtovoy wrote:
>>>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>>>> index e38f8f7..23cc77e 100644
>>>> --- a/drivers/nvme/host/rdma.c
>>>> +++ b/drivers/nvme/host/rdma.c
>>>> @@ -67,6 +67,9 @@ struct nvme_rdma_request {
>>>>    	struct ib_cqe		reg_cqe;
>>>>    	struct nvme_rdma_queue  *queue;
>>>>    	struct nvme_rdma_sgl	data_sgl;
>>>> +	/* Metadata (T10-PI) support */
>>>> +	struct nvme_rdma_sgl	*md_sgl;
>>>> +	bool			use_md;
>>> Do we need a use_md flag vs just using md_sgl as a boolean and/or
>>> using blk_integrity_rq?
>> md_sgl will be used if we'll get a blk request with blk_integrity (memory
>> domain).
>>
>> use_md will be responsible for wire domain.
>>
>> so instead of this bool we can check in any place (after prev commit
>> changes):
>>
>> "
>>
>> if (queue->pi_support && nvme_ns_has_pi(ns))
>>                  req->use_md = c.common.opcode == nvme_cmd_write ||
>>                                c.common.opcode == nvme_cmd_read;
>>
>> "
>>
>> And this is less readable IMO.
> It would obviously have to go into a little helper, but I really hate
> adding lots of little fields caching easily derived information.  There
> are a few exception, for example if we really need to not touch too
> many cache lines.  Do you have a git tree with your current code?  That
> might be a little easier to follow than the various patches, maybe
> I can think of something better.
>
>>>> +	if (blk_integrity_rq(rq)) {
>>>> +		memset(req->md_sgl, 0, sizeof(struct nvme_rdma_sgl));
>>> Why do we need this memset?
>> just good practice we took from drivers/scsi/scsi_lib.c.
>>
>> It's not a must and I can remove it if needed and test it.
> I think (and please double check) that we initialize all three fields
> anyway, so the memset should not be needed.

right:

if (first_chunk && nents_first_chunk) {
                 if (nents <= nents_first_chunk) {
*table->nents = table->orig_nents* = nents;
                         sg_init_table(table->sgl, nents);
                         return 0;
                 }
         }

and also in __sg_alloc_table:

*memset(table, 0, sizeof(*table));*


