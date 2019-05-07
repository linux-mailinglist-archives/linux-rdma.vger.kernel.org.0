Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 060451652E
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 15:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfEGNzf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 09:55:35 -0400
Received: from mail-eopbgr10053.outbound.protection.outlook.com ([40.107.1.53]:31623
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726295AbfEGNzf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 May 2019 09:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyD/e9Un7G/CBAC6WoRWwsoqQL8CwsL2Nqgp3f7fxBQ=;
 b=rppVav7Pf1iDTWg0wxHOEt970NNghjHm0B46+f9xpCprlwqCUU+DR8YRH/t2TnktDy+Zy8sgORHpLoExXzoXMV+TZq3rfzrrMa2R/eKHb4oKmfyboLbAZEAU3nq61koXgqcyKSFXBA37HDSAYje1dnMXY8IOw23IanFNLYViIjY=
Received: from DB6PR0501CA0011.eurprd05.prod.outlook.com (2603:10a6:4:8f::21)
 by AM6PR05MB6421.eurprd05.prod.outlook.com (2603:10a6:20b:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1856.10; Tue, 7 May
 2019 13:55:32 +0000
Received: from DB5EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::208) by DB6PR0501CA0011.outlook.office365.com
 (2603:10a6:4:8f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1856.10 via Frontend
 Transport; Tue, 7 May 2019 13:55:25 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 DB5EUR03FT043.mail.protection.outlook.com (10.152.20.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1856.11 via Frontend Transport; Tue, 7 May 2019 13:55:25 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 7 May 2019 16:55:24
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 7 May 2019 16:55:24 +0300
Received: from [10.223.3.162] (10.223.3.162) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Tue, 7 May 2019 16:54:57
 +0300
Subject: Re: [PATCH 00/25 V4] Introduce new API for T10-PI offload
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Israel Rukshin <israelr@mellanox.com>,
        Idan Burstein <idanb@mellanox.com>,
        Oren Duer <oren@mellanox.com>,
        Vladimir Koushnir <vladimirk@mellanox.com>,
        "Shlomi Nimrodi" <shlomin@mellanox.com>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
 <20190507134217.GX6186@mellanox.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <2e3d9da7-d4fa-e2fa-5d3b-e60c54e7f7ba@mellanox.com>
Date:   Tue, 7 May 2019 16:54:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507134217.GX6186@mellanox.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.3.162]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(396003)(2980300002)(189003)(199004)(305945005)(8936002)(65826007)(336012)(3846002)(6862004)(31686004)(70586007)(70206006)(230700001)(4326008)(8676002)(229853002)(26005)(6636002)(2906002)(53546011)(446003)(11346002)(16526019)(7736002)(81156014)(486006)(186003)(77096007)(81166006)(2616005)(476003)(126002)(86362001)(106002)(54906003)(37006003)(6116002)(64126003)(58126008)(36756003)(50466002)(5660300002)(14444005)(47776003)(16576012)(65956001)(65806001)(356004)(316002)(31696002)(76176011)(2486003)(107886003)(67846002)(478600001)(6246003)(23676004)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6421;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8df61906-2720-47c6-0676-08d6d2f3a7f7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:AM6PR05MB6421;
X-MS-TrafficTypeDiagnostic: AM6PR05MB6421:
X-Microsoft-Antispam-PRVS: <AM6PR05MB6421BF0CAFC0A7D5E041AB6DB6310@AM6PR05MB6421.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0030839EEE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: RDqr8H1YEumQmo4yovtvYO5T1fZVjfPoce4KuSGJltLaC5B/L+U1GgMJJoOYtCDU70B/yLDKw15gD9sQjxEYaPJhw6UyDtC+5VCuumckJS+F2zTQky6O29WDftXi2CwZHXwCpSjstRkipzEIulpiDX9K3ZKDD2TOPEYQOu2xV/eT0YxnrcV2YCsHzfzZnfT0JREcPff3+XolC2SlEyTqpeknpkktlDeMx9tB+o++xyiDcz/mH6ZpuetSq334wIbe3Tf5N/SWcMRgnqPs3UUdMOtR68xzlWA3Wb24L8QN2u4Xx7+bOYJkCqLUncvrj86bZNLOKMIxmPep6m7zZH/hjZfVii7EJjOT8djOqU99BBa2sB+NNPEmMYxLQL+fppRE+9kwdpnBbPF2ozKq560ztwxj5H57wU2mT+VHpZ8m0u0=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2019 13:55:25.4192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df61906-2720-47c6-0676-08d6d2f3a7f7
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6421
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/7/2019 4:42 PM, Jason Gunthorpe wrote:
> On Tue, May 07, 2019 at 04:38:14PM +0300, Max Gurtovoy wrote:
>> Israel Rukshin (12):
>>    RDMA/core: Introduce IB_MR_TYPE_INTEGRITY and ib_alloc_mr_integrity
>>      API
>>    IB/iser: Refactor iscsi_iser_check_protection function
>>    IB/iser: Use IB_WR_REG_MR_INTEGRITY for PI handover
>>    IB/iser: Unwind WR union at iser_tx_desc
>>    IB/iser: Remove unused sig_attrs argument
>>    IB/isert: Remove unused sig_attrs argument
>>    RDMA/core: Add an integrity MR pool support
>>    RDMA/rw: Fix doc typo
>>    RDMA/rw: Print the correct number of sig MRs
>>    RDMA/rw: Use IB_WR_REG_MR_INTEGRITY for PI handover
>>    RDMA/core: Remove unused IB_WR_REG_SIG_MR code
>>    RDMA/mlx5: Improve PI handover performance
>>
>> Max Gurtovoy (13):
>>    RDMA/core: Introduce new header file for signature operations
>>    RDMA/core: Save the MR type in the ib_mr structure
>>    RDMA/core: Introduce ib_map_mr_sg_pi to map data/protection sgl's
>>    RDMA/core: Add signature attrs element for ib_mr structure
>>    RDMA/mlx5: Implement mlx5_ib_map_mr_sg_pi and
>>      mlx5_ib_alloc_mr_integrity
>>    RDMA/mlx5: Add attr for max number page list length for PI operation
>>    RDMA/mlx5: Pass UMR segment flags instead of boolean
>>    RDMA/mlx5: Update set_sig_data_segment attribute for new signature API
>>    RDMA/mlx5: Introduce and implement new IB_WR_REG_MR_INTEGRITY work
>>      request
>>    RDMA/mlx5: Move signature_en attribute from mlx5_qp to ib_qp
>>    RDMA/core: Validate signature handover device cap
>>    RDMA/rw: Add info regarding SG count failure
>>    RDMA/mlx5: Use PA mapping for PI handover
> Max this is really too many patches now, can you please split this
> up.
>
> Can several patches be applied right now as bug fixes like:
>
>     RDMA/rw: Fix doc typo
>     RDMA/rw: Print the correct number of sig MRs
>     RDMA/core: Remove unused IB_WR_REG_SIG_MR code
>     RDMA/rw: Add info regarding SG count failure
>
> ??

Yes we can. Except of "RDMA/core: Remove unused IB_WR_REG_SIG_MR code".

Patches that also can be merged now are:

"IB/iser: Remove unused sig_attrs argument"

"IB/isert: Remove unused sig_attrs argument"

what is the merge plan ?

are we going to squeeze this to 5.2 or 5.3 ?

which branch should we sent the 5 patches from above ?

>
> Thanks,
> Jason
