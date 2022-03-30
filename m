Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD9F4EC50E
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Mar 2022 14:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345466AbiC3NBa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Mar 2022 09:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345425AbiC3NB3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Mar 2022 09:01:29 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AF02E9F3
        for <linux-rdma@vger.kernel.org>; Wed, 30 Mar 2022 05:59:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ri9b1d0ZaXG3ecMBGXqAvVc305JxD/a5sAIAeGcIwPZKto8O5GJQ69x69sr1fmfzKhI9rw5mWlkl5Lhil6P8Qqm2/KA9X51utQwbo04kr3OeDl/F7IEfK38gLVuqUhkZrgIz8u1/eORhSvWK1j/CybHIFTEsoz8IuCXYBYDjyh+6Y5iHgJ6IeLhkMyVzOBxHMEhrheW8JaHj1X5LTOPOcKRE0jYB5WfLToGOrfDHxI2qZGUBIyJzx3Ctg1Buz08YOvPyaOtcaAD1nxevMQrAk6s9H5zOdqlfsAXH79dIPffRHjMjvQW6B4glJ/ob8MI0fx9vbgza30Nv9QpdmceZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JqJal5RikVYpwgGNJwQgFl9TGmeT7WIODDzjwM7KEg=;
 b=Vk6spfCNT6yRaSQfYrVjp2uTVm0/3twwfBYHlIjFJ89J/oAMeu4DwEi2hQOMdWVlWgkjutdWhV/ko5QPdbzl/QYWNDfQrFc0ygpYPhrLwM4/RYLoF8fsxx6wj8RbNiIe65thO8b2ijLUr8EKzSiabXYmj0cIZp+AwIHn0lIu1WH/9zY6NkjXKkxRg/qo8G2h2JhpNMYV5FAemYWA39VKKGgz2c67SfhF+KfxHm2wDO93IIt3Ecp2KrYNiahtxT8Mf0ei/YXcQUA0YFto6i6q80LGNBrhFEckVJInAdvlKnHwZg51Q/e1Z1kpA6Zswpmv330+uSLp0ZMSyw7TkR34VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JqJal5RikVYpwgGNJwQgFl9TGmeT7WIODDzjwM7KEg=;
 b=QEPJnbOg37YRZ/f4h4CfpCUHI1QhPM+SrtRnzU833Ui8bf09WsWNl9a5W4lZ3axoZvwUpwwthCva9pgeGXpvdlleJ2uOyoyGkb2bOzCTaEFGN2QH4yE8dwh2mM+O3R8B8xxTNDi7ejznmNdYh2lv68yKaKaTEMMTGHx8bItU7Vp60YxsN2kiFdMOsfauYR8qBwB71o4aKMnx206jJgQZO2D5KWgEbYGKczgd1NnUyDST625AlpfnKNshjfexrRr55q7ogH200QnXdqqQxJztWztPI7ZeLi+K80/HugrU9zx+PcrOinUe4QpjmvKoEsWHjOwm/6lmAnTZ4I0FDcy4dQ==
Received: from MW2PR16CA0014.namprd16.prod.outlook.com (2603:10b6:907::27) by
 BL0PR12MB5010.namprd12.prod.outlook.com (2603:10b6:208:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 30 Mar
 2022 12:59:43 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::78) by MW2PR16CA0014.outlook.office365.com
 (2603:10b6:907::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19 via Frontend
 Transport; Wed, 30 Mar 2022 12:59:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Wed, 30 Mar 2022 12:59:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 30 Mar
 2022 12:59:38 +0000
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 30 Mar
 2022 05:59:37 -0700
Date:   Wed, 30 Mar 2022 15:59:34 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] MAINTAINERS: Update qib and hfi1 related drivers
Message-ID: <YkRUNssvfRZL8/a6@unreal>
References: <20220329184221.182061.69846.stgit@awfm-01.cornelisnetworks.com>
 <YkQKrn2T+NNCt9xX@unreal>
 <8534b2ec-0b12-88be-891e-eaeef0ab7cf9@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8534b2ec-0b12-88be-891e-eaeef0ab7cf9@cornelisnetworks.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ac08185-042c-4e92-99a5-08da124d289f
X-MS-TrafficTypeDiagnostic: BL0PR12MB5010:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB5010C8EE567438DE6A3EC326BD1F9@BL0PR12MB5010.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aUlX6xmfPgUVeRdTvnpc5M5qposADXO5ij9NRcpSIiSfzrknTeDl7JJHiu2CxILuWoTGphZByG+C+Znn6tyqwlaZqu1EDBcQ0bsxZULXf2WU4/ywQsML+6mt7BPpZBPlQ0M7b7RXBPvHx2nS8ZaeVoGy0+NSX8NIJuAeEsrQydunHQcllgYckRUcPsQizAxCx2xcUJLmXkjWe0JhLAvs5Ur74CHO2KeelVF34DHPpTQZijnObH4/92HqD/vjHN/j8BUXikQAvTzheuEA1lyKZQ5ZHYHrJ2BYGsVBc7oEwy+j0/76ccsEWkyyvFmnUGivI31kbReUUKEiHmIX9k8Ni3P+YwDC3j64qZow09j8Ka25RYIETlevI9sbVJgLYijvDnYL93eFrMYfAF0TN9DXTnTlJ+Hw/3Wed37blhIFXX+3XViIZcWpJrpIcpYGWqS8UdHn3GW1+CJJ57PiY7C2b748yt4zJb1oKYPXKwXUWWH96DqbSYHnbH5qL8JDcFhcBL3XXh0Bdgk15j1uZ3QY3WctKAxZLKCx6w2w+SzVB9K03VNPSs0kTzEjyMK849SCcUYJSr/Zl3+8Eexbro7Bk1rLpnkg2TY1NosfiQIeA9hPepS7Ju/eEmDnyFEiLOXlA7xEv4qgcR6Ek6gMx0Y1BhXE79oXirKDx8Qf96TJfOWBzuisz84CA7/3v1Rf+pVDHDcc8cK7AzdhiJGl80C4nw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(7916004)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(6916009)(6666004)(47076005)(70206006)(316002)(40460700003)(82310400004)(54906003)(4326008)(5660300002)(4744005)(8676002)(86362001)(70586007)(81166007)(9686003)(26005)(2906002)(186003)(508600001)(83380400001)(356005)(33716001)(426003)(336012)(8936002)(16526019)(53546011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 12:59:42.8426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac08185-042c-4e92-99a5-08da124d289f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5010
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 30, 2022 at 08:49:45AM -0400, Dennis Dalessandro wrote:
> On 3/30/22 3:45 AM, Leon Romanovsky wrote:
> > On Tue, Mar 29, 2022 at 02:42:21PM -0400, Dennis Dalessandro wrote:
> >> Remove Mike's contact from maintainers file.
> >>
> >> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> >> ---
> >>  MAINTAINERS |    4 ----
> >>  1 file changed, 4 deletions(-)
> > 
> > What about rdma-core?
> > 
> > Thanks
> > 
> On the way.

Thanks

BTW, Jason didn't plan to send another PR to Linus in this cycle, so
this patch will be picked in -rc1.

> 
> -Denny
