Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AF03D86D0
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jul 2021 06:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbhG1EbY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jul 2021 00:31:24 -0400
Received: from mail-mw2nam08on2084.outbound.protection.outlook.com ([40.107.101.84]:50752
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234852AbhG1EbU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Jul 2021 00:31:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7jXSbBo2tW/qKG3t2t+qxCZ2SarDarM7YNu/r/3pUJUtzlksRgRMQRsF8Qc0MW3EDgXW25hNOyhygYLLw+nGcWD9udT8XOz/Wn1cv45lqiIfxfKv6kSnOjtlvVWViyQ++aZllUbhvdKwZgXvZM1GZY4b3eyf00yfLIP/nu2BwrCI46bDJdM55YRZ9L2nntt7gtRqJnIPaPhdAUFGbsMsR6jjhU3tNq9xJ+UbQrIVfozyPPyJM3pVIPWLC7VwpSBzPg2dd7EL4MZ2/yApQorD5qE7osrJC3kteRvPpoQ/9lLnhAEALBDhuvMg0YbdA2ZHEVGkeUGedcMlA9rSb8CEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FAfv/mp0LaX3X0leoUqsRCMaYkXQovVU6cjWCH7F1c=;
 b=RQFgDgbtE4Hz5G7HMnNtHrLas5FaG99OkhyuFWyYNXBkLnKPAuWAzvWDiza38FwgRAX+wGvEdrbYRRM5WgQplyTTrxufFOgsxoIk8x0OrUomttvDy9FHucKFVzTA5tLeahl6CF+oxX7nLuRWqZBAs2zO9gofJDf5d5/5wNd8Al8cgt4RlGUcHEcK5AQFDJSrilJ2FLXUqK7eyu/CoBjsYtaK73heongGPay7hSO/7U4GQRKNSCOhAJGfjW73oKwfa7DGT4YuaMRqpDt04gf7PTjfFfYD9Za10sK/FZXz1ApsXWohHmmZiyNryAcergRxUhnlgnj4XW5CGvfotUzMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FAfv/mp0LaX3X0leoUqsRCMaYkXQovVU6cjWCH7F1c=;
 b=dmpjnIkwjzlqVIPruNubT8BQ+f+qTRXRSy7D7Ag+nz6SUhRs5BomzvakUxg5mUzYT5MxIfvoeMztKUa1MJIdPlMd2cI+/LwGzIiHtLdFbWJLuMg1cxpgiesvRaGc30WPx8kt975FUGgxQHBXDvaECg6lKfarlZVMni1UA5tufh8OD9cRDM6Fv/IsSYfE1UM6RWXk2zkQ3LFT2qkqF9JyFNfobr87Nbz4UA9e5s93fjDSE2SotaNaC7X95NigXf01AYyBMsi76BBFBh4mvjL9WefMrSm0enfiERFeFf9yZP2NGXc5eO0y2L30TgJX31CE7ypWGPG67QxeUyNVouRORQ==
Received: from BN9PR03CA0296.namprd03.prod.outlook.com (2603:10b6:408:f5::31)
 by MWHPR1201MB0078.namprd12.prod.outlook.com (2603:10b6:301:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Wed, 28 Jul
 2021 04:31:18 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::84) by BN9PR03CA0296.outlook.office365.com
 (2603:10b6:408:f5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29 via Frontend
 Transport; Wed, 28 Jul 2021 04:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 04:31:17 +0000
Received: from localhost (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 28 Jul
 2021 04:31:16 +0000
Date:   Wed, 28 Jul 2021 07:31:13 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: NFS RDMA test failure as of 5.14-rc1
Message-ID: <YQDdkZ83yYI4US3A@unreal>
References: <CH0PR01MB7153D5381BBC3D1D0F146E8AF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CH0PR01MB7153166CD64AE0097B72608CF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CA7DAB52-ED96-4B47-A49D-88C3B8C6F052@oracle.com>
 <CH0PR01MB7153DE8406A68B049FC81EB6F2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <20210727173857.GI1721383@nvidia.com>
 <29236B57-4AEA-4DEA-AC6F-4402FF8A1A83@oracle.com>
 <CH0PR01MB7153BED95409DC4C26CC5A4FF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <9D442FCF-D0F8-40F1-9AA1-B85BAE91631A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9D442FCF-D0F8-40F1-9AA1-B85BAE91631A@oracle.com>
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75ebc421-3bed-4d12-1646-08d951808afe
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0078:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0078712761DDCC7BB122BA1ABDEA9@MWHPR1201MB0078.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ghXlMROkhhtwamYaL4qeSpMIeYD5IR8BTs8y9/Jj40eBS+vBcjGJSBDg3k+mFd041S//3QFr+2oAdxUKjjxWIqmo6cAH/IFawX7BriAtouewf2ZUfoq29zhsYUhj1kB/1+yjCT44D7Ikpffw1mCSPx7tuyL3cLCgeKXFnv2452Fmj12rLYcNtElo2bPjS14Axi07IdO+QeIWmKVg1k02G8LIcBD1mGAhVNQO1hd55D4IB4H3R7lrkcnjoMEr57hBofUdxW2R+QGGwMILjVYfaRroMQPeKqSyLW4sCQ2X7tILXLjgxsl1Lmwric2sc2dzuZRPFRvaI7Au8HCqfw+49vPnrIFFCa9zEsoH9wCUlhpqvof6fZ02O5zBep/PnWXskmF+PYPGTWtQZQUEPffuR8dRkdGGAXI16SJSAw+FjEYnYF4QNLxCjxSOUkJ/mzWMjGhl05ajS0IeL8LqamOx909QikoFnNJVmsTmYrdXmHSLckpMJOcUN7JrbRbP7yRYqv+AkUD6nZ6nKhAQw7vqaN/oWqm/lbzxcZWflWO8Qq3ZzNfgHcX0eEX3oKg+M0PT8VBpFRInEQFomDZ7b7fzlhlwedd2vFBc7Ll2RwD64S6iXQv5rmLN/Qs6hO4++tikuXuDaWhB4ahhcDHJ0P14+RHvqSVmkWvwaB/NloOlq5IqbBdAy/tA/rAPtsZCV7irIi2a+tI/nm9zdTvF2ijdDQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(7916004)(346002)(136003)(39860400002)(396003)(376002)(46966006)(36840700001)(356005)(7636003)(16526019)(82310400003)(478600001)(82740400003)(26005)(316002)(186003)(2906002)(4744005)(8676002)(426003)(336012)(36906005)(36860700001)(4326008)(54906003)(47076005)(5660300002)(70586007)(86362001)(53546011)(6916009)(70206006)(33716001)(8936002)(9686003)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 04:31:17.7598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ebc421-3bed-4d12-1646-08d951808afe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0078
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 27, 2021 at 11:10:25PM +0000, Chuck Lever III wrote:
> 
> > On Jul 27, 2021, at 5:20 PM, Marciniszyn, Mike <mike.marciniszyn@cornelisnetworks.com> wrote:
> > 
> >>> Haakon's original analysis said that this was an INIT->INIT
> >>> transition, so I'm a bit confused why we lost a RESET->INIT transition
> >>> in the end?
> >> 
> >> Perhaps the patch should have removed the ib_modify_qp() from
> >> cma_modify_qp_rtr() instead.
> > 
> > I think that will work.
> 
> Implemented and tested. It doesn't work. :-)
> 
> The conclusion I draw is that there are still spots that depend
> on one or the other of those state transitions remaining where
> they are.

So let's revert this patch.

Thanks

> 
> --
> Chuck Lever
> 
> 
> 
