Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4707755B240
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jun 2022 15:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbiFZNXC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jun 2022 09:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiFZNXC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 26 Jun 2022 09:23:02 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B44C10
        for <linux-rdma@vger.kernel.org>; Sun, 26 Jun 2022 06:23:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTBdmUyGwXpl11+C3+yF4piybHkbxx9iMs1/zoC+89gL51p4k4PkUEkCvl/ziROjiGw6MjNmCPEhPG1HhR/lKjTcwgFIM+Qb4jyRQZ1+79NTSuudiPTkJCAW9X+iBd5LCz53fExIqatkEQp1hnGbw8Iok8i62tEeK7gIM2oKu4MjqdyC0CfiQgwX9FVLj8uCsrO//jHU9Tz23ecqpvFDjR2U/MXjvQW5gWVFTg/gXo7sgBv+X6q8PxsejB5Jts5yJv75lzWbe+fZAW/b6WRv8gYleLKiAY4PV6BJvPtgnxLLPBIzkesVLEseI9dHQGMSCgdN5Jmsx67SGpiE1p9fTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpjHvpJL8rcd+cDpE1ImEMjpA2XxzNUCfwHyPhe8eT0=;
 b=Ez8ZDDsC2LUT5ez476nv+n0hBhEZ2QfG2+r7LgXpCxW8zgZzqiXnf4yH39cxYprAsCsfOKG/p7TlH5/cioNrxO+B11pV82y6UkWumoXVZgJDtN8b4Q2K0jbXV3oVrRX4q/9v7x0joVy0Al7dBAqRZ/1pD84yjyULnrEvETrsaUJiA400U5/pVF9IntY5EVJs1vxvu8zuQHIftSTHzdh5wFP6+sENn+T58FwLM+PR3ZwoVMADF1i+IQWjijix/1okIq4Ivn/FnZ8zsBcOzk+nlbhGR8dRxzyAtEciNukWwzoY/RPIwMHLfRbYyuiI6aGfr0iAqMw3y+4OaXG3mNiLZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpjHvpJL8rcd+cDpE1ImEMjpA2XxzNUCfwHyPhe8eT0=;
 b=RIm2/b8jgtNbuyQkjG/P3fPlHkT3QRRNFAXLjbWrwnXI8yCIhmqTTsdZB1OLJBPD7GGJDcGPcw5g3Waw3Q7S0/ZxWc5YAdk/LaNrC6j9LauRWtJY6HE2NdlvJPs8MaL1Wv4t4LSkFsLrQRRk4MY2QKUK++HmvNedXGuwskDACV3KvV7aOdBBHboF7HnQh+PJ4ADux83nZwmeGAvmdCN0iAUifpUfhghK3e3GbnjBnz1X/Zh/E/bPZMR07jk8QJQWaUBmW7t8KwHZRN+nOP2jnuibMxsjD+BOkVsP++5LWM6oCz2M54e9+N8HS90SZL6umEB8qgMYncKmRyXjnZzwUA==
Received: from BN9PR03CA0252.namprd03.prod.outlook.com (2603:10b6:408:ff::17)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Sun, 26 Jun
 2022 13:22:59 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::aa) by BN9PR03CA0252.outlook.office365.com
 (2603:10b6:408:ff::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Sun, 26 Jun 2022 13:22:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Sun, 26 Jun 2022 13:22:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Sun, 26 Jun
 2022 13:22:57 +0000
Received: from [10.80.0.165] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 26 Jun
 2022 06:22:55 -0700
Message-ID: <d15692b9-7a43-4a5d-a65d-60b12d33b739@nvidia.com>
Date:   Sun, 26 Jun 2022 16:22:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Bug in pyverbs test_resize_cq
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Zhu Yanjun" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <c8dff35b-a40b-19a0-a1a0-68d5637b3709@gmail.com>
From:   Edward Srouji <edwards@nvidia.com>
In-Reply-To: <c8dff35b-a40b-19a0-a1a0-68d5637b3709@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 531ff6d4-fcc3-4d1e-280e-08da5776fcd0
X-MS-TrafficTypeDiagnostic: CY5PR12MB6527:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ni+dyCJ/WRFSFEmHAwrByjfrUIjtAS6QOH2+cV45iBO/7hT9zN1YE2gBB6+0T/DRgitEc+VfcFT1Lj6vJFhfDIEMXib211AGvSnJzH2pxvUnxVJdQYtmx21uMN0Jjk8qP4gRoMILovbZhxUqZkcwRB5SV1KS81SnHFFHf2hrUX66F4UmREkC6FTDw4lOb3JZRISX2YkD273Nf8feqQfnaj7bSf+evArPoEYQmyyf02R0W76rk3joTlj6seEovK9kQifUiPrWNhtDsRv7tyCPn+UBeSswj2VuWjz20nc6ygQkcbETtbf3rXNzc2I38WVUdze6e1OqXP7yWq3Nq6o1imCNxYT32ciHaqUq+eMOW6cazaKKjfw275Lzpr0YSYRNhOIqWSNg6y7gkxy4qkoiaeVXYM3xl3RjJff2qPfhgjpyjf7YHzbczhRuF/W5Cmwmxs+kkR7JaQ7UGwOBX98FAVV0AuEZDyCx621HmtgC9tU58GwaQ3/5cpOAfz2xBe7CT2X04kr2caeObsNl9WoTURDGeBEv3WotsUlzZoQxOtJ+gFHk8xl1jQm5rZO5tt65bh7ifOXuWB6yDTcJDUnyIdJvip246lLZeUG6YOfxqOC/w9faapuk+EygTmcEXnCI59Q5ezd2hlBX/sUmUwGO5aXphCpUFRaYGLP1d1iO2EH6utxyxyWWpfNF3uolQQKvV2d5RwLh00C00rxO/rcw74Krrsmq/8TnroPXM+xfES/ykZbgxUh1xx8RFZGglj/99oFN1qBQdWKHHT4X6Pq4k5F9Sej76Uf5caqhg6f0VO93CZCQ0KCDT/bK2WqZYKBIJTOD32dM2qIm7Ns01lGKZfhgYVaQVNQC6j58zx0Gkoua4+xySd5GmP3kaOzssIIF
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(36840700001)(46966006)(40470700004)(41300700001)(426003)(36860700001)(81166007)(186003)(8936002)(336012)(5660300002)(26005)(2906002)(40480700001)(82740400003)(478600001)(16576012)(356005)(316002)(16526019)(53546011)(110136005)(40460700003)(47076005)(70586007)(2616005)(70206006)(8676002)(31696002)(31686004)(36756003)(86362001)(83380400001)(82310400005)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2022 13:22:58.3885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 531ff6d4-fcc3-4d1e-280e-08da5776fcd0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/19/2022 6:31 AM, Bob Pearson wrote:
> External email: Use caution opening links or attachments
>
>
> Edward,
>
> In the test_resize_cq test the following is written
>
>          # Fill the CQ entries except one for avoid cq_overrun warnings.
>
>          send_wr, _ = u.get_send_elements(self.client, False)
>
>          ah_client = u.get_global_ah(self.client, self.gid_index, self.ib_port)
>
>          for i in range(self.client.cq.cqe - 1):
>
>              u.send(self.client, send_wr, ah=ah_client)
>
>
>
>          # Decrease the CQ size to less than the CQ unpolled entries.
>
>          new_cq_size = 1
>
>          with self.assertRaises(PyverbsRDMAError) as ex:
>
>              self.client.cq.resize(new_cq_size)
>
>          self.assertEqual(ex.exception.error_code, errno.EINVAL)
>
>
> No where does it make any attempt to see if the sends are completed before testing to
> resize the cq. Software drivers might not get finished in time and fail the test
> because there are no entries in the cq. Technically this is wrong code. You should test
> for the completion before attempting to destroy them. Or insert a small delay.

Have you actually encountered this issue?

I understand what you're saying, but we only send 6 WQEs , and we 
intentionally don't poll them (to not "drain" the CQ).
It's enough for the device to get 2 WQEs in order to pass the test, I 
don't expect anyone to fail on that, unless there's a real performance 
issue. In case you encountered with this issue I'll re-look into it.

> Bob
Thanks.

