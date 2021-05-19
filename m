Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40738388673
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 07:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhESFVF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 01:21:05 -0400
Received: from mail-co1nam11on2069.outbound.protection.outlook.com ([40.107.220.69]:42878
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229598AbhESFVE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 01:21:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5WxxC05lj2Ifzi47NohVWc0UVoEICHKmQftrQQQaGP8OEKLs5lxzBV0KRt/CLyf4FzclCTuqqQUExr/UaiyMwy1Xf6uo9vlJ7E8d4hVpjo8TYldCj42yT2L7YFTW6n9ZtsBft8PswWgZVH41ZMWifyi5WkQ6TbB1yI54BS6VwjT8hIFwDwiVu9ARLUGqW1yurQyKKssbin73pC0Jpf8D4nFlm27nzLImG7u2PED5MqtfpBjdExbGqpNBnn/yPcAN+L2S4JDdF3M/2r76PrUpyH7/2su7rf2gZ3L1I2PcFnz+aG1sRyoy/7jb9RGF7ZLqG882W1oeo+SQitXhW2sfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0L7IriWP3xUYxe02PQ51ACP7vTOphU/5M24D+7Gowio=;
 b=m0SZCLHB4BhsvpCSYCHw8z+l49sZaaVgxUuUmQRWBK/irOsN0dksDqBhKOM+vgzZoNzM+35TEO76thmsoeXWXu+cN1Wey5Io36D8O19+CWJhfkQ7/5MvQFP8RLK6kqqwe52X3C09NfNlVUVLunHSrezURGbgjGwTEW5qlrnJxa4gbsAm1VwxEQKXBHF4LZifDHJcJQVDWZusxlirMoaYewuehhz7Yse11x262Huu8rTiWUljB3ra0TGsRPel90FHf/9591++mzMOcVpF7yLzsRkHA4rjmvNf2SWaOgFB3NRbtLuAh4+Lvs45tjkVerhkXktgo8lq2mZWYvvPch932Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0L7IriWP3xUYxe02PQ51ACP7vTOphU/5M24D+7Gowio=;
 b=s5nTLcMXhl2gXisv24j5c2zBav89fwIA/rFrnbORq1W+XQ15qTOf5rSnwJw0qRsLiYdOBJDzjmvHHM5MSC1BLjQyU/FXCrwfHsUvXscdOcVc+Z5MhI+DpsjjB/oRCofv2hvD2kZRfMER4fsnbbahR6D0PJxtsVG4pZ6uygIDBV+NIZVGBMVuPc3CodJBkCfadJuxDBbmfFDMJRDN1A9KOG7XwBN2AbW/26TPE5ur3BVY68ePdKn4RbS/9W58LLA4O2j5DJMdsOirf5GzoYdDqwd3onqjWnkGhD3ZXa6tL5vWXV7kTZOpJwfAH8jKWj/pxGqXO+UEOXEdQ3EOW3aK+A==
Received: from BN1PR10CA0013.namprd10.prod.outlook.com (2603:10b6:408:e0::18)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 05:19:44 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::37) by BN1PR10CA0013.outlook.office365.com
 (2603:10b6:408:e0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Wed, 19 May 2021 05:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 05:19:43 +0000
Received: from [172.27.8.102] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 19 May
 2021 05:19:42 +0000
Subject: Re: Mellanox CX6DX switchdev mode VF fails rdma-core
 tests.test_mlx5_dc.DCTest
To:     Jason Gunthorpe <jgg@ziepe.ca>, Ido Kalir <idok@nvidia.com>
CC:     WANG Chao <chao.wang@ucloud.cn>, <linux-rdma@vger.kernel.org>
References: <20210518092537.mzlmqn7eua4ugztu@MacBook-Air.local>
 <13a4c4a3-0914-c8c9-1873-da83ca0177ed@nvidia.com>
 <20210518124411.vps2uyjfzo4ikjjz@MacBook-Air.local>
 <4eb5c13e-6e9a-5d79-da7d-bd4219eef447@nvidia.com>
 <20210518165222.GS1096940@ziepe.ca>
From:   Mark Zhang <markzhang@nvidia.com>
Message-ID: <8909d509-a419-36ea-1529-2164d8550195@nvidia.com>
Date:   Wed, 19 May 2021 13:19:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518165222.GS1096940@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e025049d-fc13-47a6-9470-08d91a85b640
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5336CBB35AA544B3E6819027C72B9@BL1PR12MB5336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ptLCSTX2tyTSqWXxYrWKEJew3T22eSq556jLdhIJVm39kG2K4SPppAjeLqrZy6ithl7UEKN1XW/SFnkEzXdmLyGLsEF0sYrAtcYn6I3C3BclcxpMTOu70EAzMUS99Q3v1QiGCsXG3NJZA7VxgG2+ZW65P1z7U9qZQt5rJNq/7GY+VbfjcV17MTjR7m3cCAmOSG/6JE91I9thLjKa3yyJ8D0sJFx+G9+6OcylYC3gX+kAKW3vYEKY8TblTIDsF0TneIm2cSgoDWNJzVjXgPw3Yy1fzaBy8X2ncKJo68h/ze+ewxpqrWHF6EaG8in8UkYtabJR09E7QzOVc/rxSp00ocR94lPYClqS76FTB4V5He8qDAP0erIRddXkZ/KDtvve0zLXOkfUhzrFzvctScAwN5JlKJOL6ffSa2KT1KQcv4UxmI2MYnNBAIl6RviOWKzTDMezyT9phyDZYa7D4mSknpDrhfQog/ix9txfjH+GeoIokn+oGBbhrGM8PQkX2y4+3ZdhXbWZ12VRPluKdsEp/9d8qs6TmpmTFte7sRBF8gOD7jiPPYVYgKSjke5IFn9187OGNCIfo5vFOxCxTfhez1uEOe+ZvR+lm9YmXcoQUgbm0bb7DK5stCfBSmyhvM//CDO+p1hMRBzOIAbQ2HyPppbQiXbo6k3e0TMr1gM/c9/WLTvQlFsqmOTwyd3sTKXDFxM6WutNwkFm7VQworqIpzvpt1AVsmvKZ7IhYMaS4U157/EJLDqyE0+GT96afvPymjkSVme+/rOUyNULEVllChXaGaXD+B1B2qRElZUXNdc=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(36840700001)(46966006)(110136005)(2616005)(26005)(70206006)(16576012)(336012)(966005)(53546011)(54906003)(36906005)(5660300002)(186003)(47076005)(16526019)(4326008)(6666004)(316002)(6636002)(36756003)(8936002)(7636003)(82310400003)(70586007)(2906002)(31696002)(83380400001)(356005)(36860700001)(82740400003)(478600001)(86362001)(8676002)(31686004)(426003)(32563001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 05:19:43.8065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e025049d-fc13-47a6-9470-08d91a85b640
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/19/2021 12:52 AM, Jason Gunthorpe wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, May 18, 2021 at 09:00:29PM +0800, Mark Zhang wrote:
>> On 5/18/2021 8:44 PM, WANG Chao wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 05/18/21 at 08:30P, Mark Zhang wrote:
>>>> On 5/18/2021 5:25 PM, WANG Chao wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> Hi All
>>>>>
>>>>> I'm running tests from https://github.com/linux-rdma/rdma-core/tree/master and
>>>>> got the following errors from all tests.test_mlx5_dc.DCTest tests:
>>>>>
>>>>> build/bin/run_tests.py --dev mlx5_2 --port 1 tests.test_mlx5_dc.DCTest.test_dc_rdma_write
>>>>> E
>>>>> ======================================================================
>>>>> ERROR: test_dc_rdma_write (tests.test_mlx5_dc.DCTest)
>>>>> Traceback (most recent call last):
>>>>>      File "/data/rdma-core.master/tests/test_mlx5_dc.py", line 62, in test_dc_rdma_write
>>>>>        send_ops_flags=e.IBV_QP_EX_WITH_RDMA_WRITE)
>>>>>      File "/data/rdma-core.master/tests/test_mlx5_dc.py", line 53, in create_players
>>>>>        self.client.pre_run(self.server.psns, self.server.qps_num)
>>>>>      File "/data/rdma-core.master/tests/mlx5_base.py", line 36, in pre_run
>>>>>        self.to_rts()
>>>>>      File "/data/rdma-core.master/tests/mlx5_base.py", line 31, in to_rts
>>>>>        self.dct_qp.to_rtr(attr)
>>>>>      File "qp.pyx", line 1113, in pyverbs.qp.QP.to_rtr
>>>>> pyverbs.pyverbs_error.PyverbsRDMAError: Failed to modify QP state to RTR. Errno: 22, Invalid argument
>>>>>
>>>>> Ran 1 test in 0.051s
>>>>>
>>>>> FAILED (errors=1)
>>>>>
>>>>> ===
>>>>> Additional information:
>>>>>
>>>>> - VF is LAG and VF binds to host.
>>>>> - DC tests fail when NIC is in switchdev mode while legacy mode is fine.
>>>>> - Tested on 5.12 inbox driver or OFED 5.3, neither is working.
>>>>> - 5f:00.0 Ethernet controller [0200]: Mellanox Technologies MT2892 Family [ConnectX-6 Dx] [15b3:101d]
>>>>> - firmware-version: 22.30.1004 (MT_0000000536)
>>>>>
>>>>> I worked a bit tracepoint on 5.12 inbox driver. It seems like there's a firmware
>>>>> command error for CREATE_DCT.
>>>>>
>>>>> I can provide more information if you ask.
>>>>>
>>>>> Thanks
>>>>> WANG Chao
>>>>>
>>>> Is there any syndrome in kernel log? Try to reproduce with debug log
>>>> enabled:
>>>> echo -n "func mlx5_cmd_check +p" > /sys/kernel/debug/dynamic_debug/control
>>>
>>> [26538.391991] mlx5_core 0000:5f:00.2: mlx5_cmd_check:820:(pid 27332): CREATE_DCT(0x710) op_mod(0x0) failed, status bad parameter(0x3), syndrome (0xa22b82)
>>>
>> This syndrome indicates DCT is not supported in VF LAG mode here.
> 
> Is this out of order:
> 
>      def test_odp_dc_traffic(self):
>          send_ops_flag = e.IBV_QP_EX_WITH_SEND
>          self.create_players(OdpDc, qp_count=2, send_ops_flags=send_ops_flag)
>          self.check_odp_dc_support()
>           ^^^^^^^^^^^^^^^^^^^^^

Not sure, but I think it's a different case.
