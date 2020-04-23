Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B8A1B61E3
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 19:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgDWRZc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 13:25:32 -0400
Received: from mail-eopbgr150050.outbound.protection.outlook.com ([40.107.15.50]:45893
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729673AbgDWRZc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 13:25:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpHIAbwAEWRNGBEtgmkPvjlZuWFjPS9hQO7gJcfDKE9MalMLwzRsqwjZe7IiM5NrEbNqDPrCSsaplHa78FHuurtRteUxhLjFX4i70YoJnMd42cCByee7SsOT8x55LsVdGxubCgmaKZOQjURvvUDC53+utHeZgv9d/1dLR4q0P/2+GqZCFGBsvEXH178rIk0XotnDGpfuKI4G4LlsROiqgBERQRe9ppbNuOTiu56TKHhDID2798KbmBpzmnaNRJ15CxgXo2uv8NtGmRYjQ9+8U5ZAKioGdB26F3dwt6p4071ATHX2MbvE+1hrWqt9HfnPcXdk+aUk5P2hoai3/CIEAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULK2bfwWsSqrPzmu/DHztonew4eaPP9mK9InQNCVMM8=;
 b=HhVdrqpNmZyINFgS9HuMIhiA+c259+W3h8fY9fcN9NRwyODFFYZRGxdoTRR0R1knjiOy9Yr94BDyi/DLNU73ONsFeBl6nk6BSaJ0eYtvCPzw3YzqGxirOQ3Wn7Gm/g+w4DUrr3U2OoJJrnlgxUCwjsMKQdc4lCl/fLJr2ZIsuoWMMqB02grMufzPQ2Cq8GTAQjdFzkHL72WNrO6QYshI1yMoKLg2tpeeaaAnmYdP616IGcV5+xf+Tkg3dkRBR6syKbsFOWHyUFSR+AHXbMCvfULwvTMG0WtEtQdcB0VZ/1d3cexXpzDcirov/Evn2fnD89hwsltLBTistyVFvuFdFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULK2bfwWsSqrPzmu/DHztonew4eaPP9mK9InQNCVMM8=;
 b=CjYxLb6XfiWuUqu/oEEOFSgHlh9eq9YNBs8vh91m6oU5qpfBgmrMdDWU/TvFvzIH6PdzTlsM/Gn10kioOt27eQ6AX4FwEi/1gMKDUlq0V+oc29kOU/e5UEIBLhkXX1LScaEr9k4l0ippHcpnQsiH5sbrNHL2OTXhxtYbi6LFRyQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB6388.eurprd05.prod.outlook.com (2603:10a6:208:146::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26; Thu, 23 Apr
 2020 17:25:28 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 17:25:28 +0000
Subject: Re: [PATCH 15/17] nvmet: Add metadata support for block devices
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org,
        sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
        linux-rdma@vger.kernel.org, idanb@mellanox.com, axboe@kernel.dk,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-17-maxg@mellanox.com> <20200421153339.GF10837@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <3992e1fd-efad-0679-7817-f004b40cdc76@mellanox.com>
Date:   Thu, 23 Apr 2020 20:25:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200421153339.GF10837@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0004.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::14) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (217.132.177.164) by AM0PR10CA0004.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 17:25:26 +0000
X-Originating-IP: [217.132.177.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: efed7b26-4c67-4287-d70e-08d7e7ab512f
X-MS-TrafficTypeDiagnostic: AM0PR05MB6388:|AM0PR05MB6388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB6388F957D3E02575A8D25838B6D30@AM0PR05MB6388.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(16526019)(186003)(4744005)(86362001)(478600001)(2906002)(2616005)(81156014)(4326008)(8936002)(956004)(26005)(53546011)(31686004)(8676002)(66946007)(31696002)(66476007)(316002)(36756003)(6916009)(6486002)(52116002)(107886003)(5660300002)(16576012)(66556008);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKMNJaY1kUoH9IkR3a6MuBGj2m/RWQm4RBay/RuNKO9cDKug/t+rcHvza923dwHw8bY2c4954tuC3T+Lh3x8ApdsvcNTZaKp9fBoApUdsILRm+AgohQ8TkQLFTYmkDQth8GZj2JwdzaY56fuZj6m3BG5TTv+hmRTPSWbigFRfEFaPkGnzysH7HgDisTIsdZDGuxYnrSrKTtaZeALo/LU29V6gXE07ZPrWb3WuQK+4oHxkdD0aeYotZYo6802/IXZb2Mq7JBo6dLN6/AcEnL+bkSO6/YeCOOXqcPFbGD0Yzyvs29Orb2rJkUcrkViKmfA5plnncnYhvQ/+4cpK1bcM08nwXfxSYD9dx1S2iA9npxRJuEsOIUluvomlPqE7pTdgqQvhkwYnPw5bKBUyXabtoN8nRMa4SEPlYlETipuoUSLHQdROAP/1oXymOi11fa6
X-MS-Exchange-AntiSpam-MessageData: 6d6y1OHVtOjWEuAJ4KCfccO3NVtaksADRqO0dgdV93r/yBv7RFN4vzciz4ktk6g/KHdIzHoWCKAdIxtokbgXheRKy8ZrkyvgyI34POWC1Q5mVwLwAbOVZOcUa4R2bzAOlHU8p45m922Nv5G9nrmC4jShv5j0qOG+fnjDzBdeYkQ09ZQr6EqNghYAsvVXG2uuyXibf3lqGf3pj2hzn2gJ5bkWSdh6lUVaQUDqhUayVkq9fV42gthbaWtF7wP7hNM3fajmGA+1HSWASsr0Z6rv8JCD9vF1qGlOo8f65lozMcqSt+2kzT1tXnCftVfi7s+SlmBWrOow04k5eFlsMJ250U8Sefgabl+oG01niQnuND0+xlScl0HzMVfIVVbD2kKBKTCbDkAX12OOZlgQpNSYW/ZuuxaJ7Q52Uft8XuXvSAOJpLY3oreS4SfxH5u53HHK8IwUJ8LM4Y5U5dVI3UFFiS/orVoIYwP1vidQTSa4ZSwsNDAqszwQQspv+N6FRKx9Gmq3M8Okb1QPIJ4cvRbLiGre8TREmBhWXDZV1lY6kP95QxN2RReH6aXsodnXHj5TSb+OOKNP9PLvj39AwQmWv7wYgAAEGiEZLXdf1q8Bx/EpGmAcTmbVcp9fJuy4negu14Q2F6XrUWkXACJ2DV4gtUVuy+0ycEP0PomM0Ce7pIBMPgV9h/dkl/G82Ub3JVIV4GbHAHLa6trpfo0Ik4+Cgx6KH4cVeq2g43k9gZvgaLCSEnkpCFcYeoFht9YTTxJMdDnZjPhDk1x8rB0lsDLGZ7m+xL+iSirbR5RmulQncz/ppmscKB/YiTtHv8mS6AjI
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efed7b26-4c67-4287-d70e-08d7e7ab512f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 17:25:28.8585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tL0dguBxhN3D/V0AB9oBe6PQXggptp/AFH5T2aY5+moIvABWD44sgSGThwRz9OGelDbH53Wudxm7KoeSI2uKpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6388
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 4/21/2020 6:33 PM, Christoph Hellwig wrote:
> On Fri, Mar 27, 2020 at 08:15:43PM +0300, Max Gurtovoy wrote:
>> -	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
>> +	if (!nvmet_check_transfer_len(req,
>> +				      nvmet_rw_data_len(req) + req->md_len))
> Shouldn't we also calculate the actual metadata length on the fly here?

we calculate it during nvmet_init_req.


>
>>   	blk_start_plug(&plug);
>> +	if (req->use_md)
> Can't we use a non-NULL req->md_sg or non-null req->md_sg_cnt as a
> metadata supported indicator and remove the use_md flag?  Maybe wrap
> them in a helper function that also checks for blk integrity support
> using IS_ENABLED and we can skip the stubs as well.

I'll replace it with:

static inline bool nvmet_req_has_pi(struct nvmet_req *req)
{
         return req->sq->ctrl->pi_support && nvmet_ns_has_pi(req->ns);
}


>
