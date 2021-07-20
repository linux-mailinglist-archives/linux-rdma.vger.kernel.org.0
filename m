Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD2C3CF6CF
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 11:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhGTIsK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 04:48:10 -0400
Received: from mail-mw2nam12on2040.outbound.protection.outlook.com ([40.107.244.40]:37952
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234950AbhGTIrN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 04:47:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjfdHT+uvDqRj/PdMr0qawclANdWMloqgH8vrZlaYYKkBRWih1wTImJQ697FMaHqfSAw74SMrxRWNX9hl7sZ6GNNNnVsA9UQ1JFt4K7qxDXUZGF682le+PhQq7/fDsVMB5+qEBFJGMYaZ5N1pGHMfvdi0ZdtIIXuzZr8igzXQz09EyhOofIKLxcaEaY7KClVNImCPXsk0kUxcJsiDqPRDGe21SIu9wvP6ym+45t7Mv/fLTxGfZ7XKxDBFT9JAp/Jia1LgO00JMu64wzKzuGrDfkO+/rjCpCX12vGrCTpS9YxGlYGVnho01e8bTIB6790vUdjeooYxQd4hkuClKWJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=js4P29a8r0uTJ7sP1ZZc2TjJ1EX5xEWOwfgEGtN8+Yo=;
 b=T/vui8Cz8MBawfNt/vfzf14i86qUFKu0+szkefpgR82iXquA+KZzmljRUSHOau/rxgJwz3l6DvEjNuxihqqczaPR52zYCalGoq/B1vgfq1MaiNwc8g2l4YuFG12RyJaNPmCZvRXxcuhCoiUZsKR/r/3FoepQyUJEt2BpvJmfzD7icTjaDzPVAvZWYtNxs3Ko3D/bRJWOD5adI1g/nOlDcVGWswnJUhoKUEnps9chTVTy7HfQ4QhVVVbU/3WOmSra3QdcXGOlAtTdLb3gjCuwV/c0r1OFrG4CtRVVk8Uy/sLwtuHxaOyhsDijDmt2KfNpGpVEdUcWrkr7E+qYbd1mXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=js4P29a8r0uTJ7sP1ZZc2TjJ1EX5xEWOwfgEGtN8+Yo=;
 b=EeeDLPskWXzkM9ljL3MruPpeqSa/i/+oU6X6b72ljp34LYNGqGdCcV4yQrq+rxtyxJ7zHIseEF9ktJnRlc14G7HRE6yYJQqCgLZFFI7DFjiHIokUhiWYLJvSAQfCPpqa+70cx8rgTQyp4akzW8thkYZvqQ4D/QwGfsEziqmltc7lkXlQld4dluO00VcmzJI7Yu1+YDmBggFto8E/gWrQm4MfDh/moIWecEo9GQrgPB6Gcbi0u9t000zFAyeDTFDFxfsu1yUJLeCJXGjfeKLynEiSpSPFXHMRHmr29WaHq+3/L0SLeh+x39GEvUgVx92Szdz5mnMEod99DmX3pH9q+g==
Received: from BN8PR16CA0019.namprd16.prod.outlook.com (2603:10b6:408:4c::32)
 by CY4PR12MB1493.namprd12.prod.outlook.com (2603:10b6:910:11::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Tue, 20 Jul
 2021 09:27:51 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::f2) by BN8PR16CA0019.outlook.office365.com
 (2603:10b6:408:4c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 09:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 09:27:50 +0000
Received: from [172.27.11.115] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 09:27:48 +0000
Subject: Re: [PATCH rdma-core 03/27] mlx5: Enable debug functionality for vfio
To:     Leon Romanovsky <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
 <20210720081647.1980-4-yishaih@nvidia.com> <YPaOlTDrV877Jgnt@unreal>
From:   Yishai Hadas <yishaih@nvidia.com>
Message-ID: <2054ad99-254f-4e46-d193-4b1183000d87@nvidia.com>
Date:   Tue, 20 Jul 2021 12:27:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPaOlTDrV877Jgnt@unreal>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae3e51e2-dad6-466c-8857-08d94b60a51d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1493:
X-Microsoft-Antispam-PRVS: <CY4PR12MB14936956CF21E4E92696A7C2C3E29@CY4PR12MB1493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WkT70WqkGNiJ52Rd/G9UIlTJQFFWxZ+MrviGNYVHmmw7jQlNgrdI7U69dAaQt5o5y/o7xt1h5QpIo5pXMCM54S6RRwVAAwPj4xTwisYa0vWAd6h3cP4t+KQbQSrbycVxdcfZxywPwerUUJGaafZJuSTFcOV7PuLA/DJr1KJCl3YzYE//g7t8I+IAPd6GnAjv0rPYTLriNXqIW+d1USKbiA2ul+OvPyaCji1ycFTuo3roZLhrZDzykWJLWQXavyl+zY9uNLmXR7ewIpaCI9aVhELxKW1QJaP1ddRjFIhxpE6eTMkXdiQWecllYz6CNtoUyAQh/PzZKV89nVSIr3Tz1tae42Fdc1c3my8516i+du3UI2IRHcdoUTNY4A8AzhdPIiJTWyZBEl7Gj6CtROAsH2j9awkNesLwf/iJ4/LEndvZRA62+KKsbDO3xanNKsrQBL32oeH6ha4kypiM79X28a/gpXOio6FqQcQmtzRH0CVHsMsB61zePtpy6vk4ySR8HHUXBpDDpHlIOTfJYCdJffIRvFP1BHfyxJm9SV5lQFjTEINtiq5xk2mAf4sCSPlrFHCYHM7wNBoZIZzwFIq6NnTSTa8Dn1TTaYbv7oE0yQmV39FlhH5c2bOUyXtVxgPYFme0lpLO5EVVrNZfFRMEor/asA5TyxmjcX7C3BP5daXEn8GPh7vsxOsn3201tX37hWdZlHxWJdJL9/cDUxNxbTmhnqmJzZn7x9L4xk+DlGsp+lehVke+kxUJWMUa2G7db0PAc83Nw1NCb/4nJ93Hpx5YN0O9eZ2mF9FQAA5LojAXmPTJPQjNpiSXqmI+in/G
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(70586007)(47076005)(966005)(70206006)(5660300002)(36860700001)(316002)(2616005)(336012)(31696002)(426003)(2906002)(16576012)(26005)(83380400001)(36756003)(4326008)(6916009)(86362001)(53546011)(54906003)(107886003)(356005)(508600001)(16526019)(7636003)(8676002)(31686004)(4744005)(8936002)(82310400003)(186003)(36906005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 09:27:50.7186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3e51e2-dad6-466c-8857-08d94b60a51d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1493
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/20/2021 11:51 AM, Leon Romanovsky wrote:
> On Tue, Jul 20, 2021 at 11:16:23AM +0300, Yishai Hadas wrote:
>> From: Maor Gottlieb <maorg@nvidia.com>
>>
>> Usage will be in next patches.
>>
>> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
>> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
>> ---
>>   providers/mlx5/mlx5.c | 28 ++++++++++++++--------------
>>   providers/mlx5/mlx5.h |  4 ++++
>>   2 files changed, 18 insertions(+), 14 deletions(-)
> Probably, this patch will be needed to be changed after
> "Verbs logging API" PR https://github.com/linux-rdma/rdma-core/pull/1030
>
> Thanks

Well, not really, this patch just reorganizes things inside mlx5 for 
code sharing.

Yishai

