Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3491277ECEF
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Aug 2023 00:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346760AbjHPWOF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Aug 2023 18:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346897AbjHPWNx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Aug 2023 18:13:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20605.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::605])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536902D66;
        Wed, 16 Aug 2023 15:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEhD4k8jTsPo7Duek3vZaU5W2fsVO/ep8FsXU2VqAoUufxfvQXiMxCADcV0VJYW4b+CzZdmFRdkQN6IWopQJJTgJT4oR8hsu5p4e7udgi7lq9hDfOpRI+mLUic1eXMqvTaCf4a3ukWpE1CruL89f4NM/NP64YAadDFo1KnGBrlqD/7gNuVOUVvXFSM7R1FkHGPlQVP0yjU2EjVIUkH4QDHpteNrN+ITuw6Rf1LL3FP5ceVB7eaz2aAUYKOg7T7YyH0o5ZXgP8SGRSRqtS5moezwzlIYi9GMfagEyzn8iK7VKIWwVxOXXo8VyzjWRf3S6xfIvQkdY1Okb8xUvOteL9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEa1S3Jjl273nU4n/bARMyWrfZaAMKzaM+f9w4FrI0k=;
 b=ZJUCAVd6BPs3A/D2c1DzRL16yV4QOalMiVpasZNKQUZPjBIAmPExfcKdwe9c6FFlca+wOpO5ETrhLesioUxQ2xkV/t2I5H1DHFLmZU1lTVxhJZNQl2R3D0vL4x8KjHdae4flz2CS8p9zqea2lHRMl5ZEHylWXkX3t49Wy2atfcJX/cMWnoRFhilPgzBsxvBREJnZRvq1fiaN3Ptx63bmxXPFzlzetsH49+9zdbRlrh+NUm2btFULQpa8T+9azsOBSjGmFc1wA5cLSBkU1eb4DcnSrqAlqYcsCJs/pzlYRbcvpwIbe5lbDacDBET9wtlp8akiqekea7fMtiR/wggAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEa1S3Jjl273nU4n/bARMyWrfZaAMKzaM+f9w4FrI0k=;
 b=rFkGzMN9STYT9Wm7aXdu+f8f/rtbmi37UExzfKSDlZtmsE7Y7nI6sEo9nqlEYTB4CmIuPdQWwwrjB6wp4EouN0SvFRsmXJUS5Yk3jO4MRZf4Qf5eTvFwg9Z3RE2IYIlDn1KT4H4Kn8bSAJGAhT2XNiBTxX/drQja6rGJt11je8T4epjKQkkLuqW5i2fh0VdWwYMxrDEdi84G9yo/TPhY7DMgvyhJeZAgy6iyJX2bx8CchTH1mBTaacV1xcCKiQAzqEvmsR61w/vaBspWT5Rp6s88JilNKpGHzIspWm7HDBrk2l+M3WsKbb7jWNuEQ6eQnSDm5O4ndv+sYU1sQ01lgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9134.namprd12.prod.outlook.com (2603:10b6:408:180::21)
 by SA1PR12MB7176.namprd12.prod.outlook.com (2603:10b6:806:2bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 22:12:04 +0000
Received: from LV8PR12MB9134.namprd12.prod.outlook.com
 ([fe80::5299:9b83:4bf3:fc51]) by LV8PR12MB9134.namprd12.prod.outlook.com
 ([fe80::5299:9b83:4bf3:fc51%5]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 22:12:04 +0000
Date:   Wed, 16 Aug 2023 15:12:02 -0700
From:   Saeed Mahameed <saeedm@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Saeed Mahameed <saeed@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-pci@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Moshe Shemesh <moshe@mellanox.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net/mlx5: Convert PCI error values to generic errnos
Message-ID: <ZN1JsroNi8iKSGNf@x130>
References: <ZN1Da7oOOKQ/FnxI@x130>
 <20230816220425.GA301099@bhelgaas>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230816220425.GA301099@bhelgaas>
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To LV8PR12MB9134.namprd12.prod.outlook.com
 (2603:10b6:408:180::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9134:EE_|SA1PR12MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa23eb7-eef5-4312-ac81-08db9ea5d28e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FPlnYWFSCdeY0ujCqrzdOmW2TnAFlZcHsyUuXUttx/M72E5DKTdoDQaa2FA2zlJu5Ey5Ij9AOSQ9kl0njoNhpSZI7ow7IYSh+OlKKXzL5QZfNz4lONzXOT6wzv2R/nJGug9L8jk3+KoP2rTS3ReJJjq9cI7gne1dO/EmBqEoIMYTJjWuWu2z4thvYnwUxSJdZCcITRsDUgwyT+1pWcU3YE5fC6g+Z4TL8VejwqghhAKFsfcrG2MiUmr3sVpGWaV0RE4EyqJbFJVOfEKa/K8LENn6DK/7D2BRdAw7O8HESfWyjf9Tz8C46sFGf3M7pIbc2ubwHYuWY9ctY6/68vvyV2gkvbJvRRCb6EFDCbmFAqNU2axk0QnEn1zQAF57gjjWVMk3Z+wmumuzAahthhyZz+Igm6Lh8ssmJMVz9E6YO778W9KKsBjN3wficmw+OYt1jIYSdinJRkcs0Il7RhNTeEsPApMZ1stlHgVM/hx9DtFKJqspMEt9SRkuoo2YjqKAaxtNvrQs/GLJHLvDO/O75vlq0PQXBHyfQdcREZr9eqZ2qNrj2E5zkRBLp7gdg3SAQwxatt/O4azc5ApjtWdParSGJYeKe42lgXIWHtFnZjsynOHgO1cnUMqoLpI9X7XRB5RKBT+DrQP0oPua82vphw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9134.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199024)(1800799009)(186009)(316002)(54906003)(6916009)(66946007)(66556008)(66476007)(5660300002)(41300700001)(84970400001)(66574015)(38100700002)(8676002)(4326008)(8936002)(33716001)(2906002)(83380400001)(26005)(478600001)(7416002)(86362001)(9686003)(6512007)(6506007)(6486002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?RhfOqNEL9QdufkA8pcqIWgCWEnSxw2CIq6ui5uh3Ofatv2NVu7N7zizLQO?=
 =?iso-8859-1?Q?5GtiIMUl4WTyYWSypRGPoW01EjOsM0xb2X9nRVFOTmlNZRHeoyvpwfcfJl?=
 =?iso-8859-1?Q?JxeuXHufUaBZAu5XHrGOvqo4TL2XwJPSXtUBsYv4WFsXbyz03Zla1C0X/G?=
 =?iso-8859-1?Q?LZ2qz4hgmiHXUNPbn7T8xpHYtLdReSQxHF7633EoMLdZaSs92f7s2ZDOS8?=
 =?iso-8859-1?Q?O7qunsZSA7ThlB03SuaUn2aTJxFSaVxFLLpqalamh5caIbSNSGDCQvkNRf?=
 =?iso-8859-1?Q?VLvXfh6z7guh6+GtamvtTtg6cf0wB2ixA6KvKXZJRYH03sG0/PXmwwxBHo?=
 =?iso-8859-1?Q?/SnH5UXfQl+mKuSh/1TCpbNSoj9D6tlYOIyx1I8GM3LmPpLe/oErr1c/nd?=
 =?iso-8859-1?Q?rkgJPwJTpIDfOlxOaewi4T8bOYF6B0gyHjyIFZk1FO9E7KaBiiJ6cokZF8?=
 =?iso-8859-1?Q?gepFtRJhgNAGKcyl7Uf1RK0Eus25XE/Nx3DcamlnecEsCehhFFwLbd8wWi?=
 =?iso-8859-1?Q?nTOCaeapgASzvTH1czlSK45MbIRv3w6Mw3HpLaVGHveob5YjLX5QCZlujg?=
 =?iso-8859-1?Q?Sob6EZGwKat6lLvWzv503Gx4v37qcyhmEjcURMY4ATOsjC3d1xLHtk6yWF?=
 =?iso-8859-1?Q?58R8kLq8kvw+oS41ZDXcVE7p5Dh8DIrR0FfSZJwJ6+tF3CjOsimej0KLsj?=
 =?iso-8859-1?Q?FFY2wg1zg18vl9iYEcPoxvQoBIXiCAs8DJ1a5KyQXdM18F1wnxm6G056lx?=
 =?iso-8859-1?Q?qJaWA0TWG4IwnaRtyhlotx4yk3XtceSOp+EifKCCzxsN+B/U1pUC80unWz?=
 =?iso-8859-1?Q?c6kSbgxm3Bgmhu0LdzaT51kv+38KT4z+mDB3kyNDaJpTB2BFElukr2egMg?=
 =?iso-8859-1?Q?br1IZ5yN/TmZ5V5quQNMtQbTZ9mgfkCEVdBnJfG9JuL17cAsFBko/adPPA?=
 =?iso-8859-1?Q?qY+P6moVJ9fatpnk/EQJ5NOhVmFALTbvLbksj9X5KH+hK3ZXe5AEGwkI+L?=
 =?iso-8859-1?Q?Xner1YyXYCN59etaIoOaDGUMiyTyC3QsEPIfdls8BZ/YlQ8RMnhWJd3KBZ?=
 =?iso-8859-1?Q?tk2Wa+9l5lqIaxZ757A0fBQggEl9uFu4LJUfU73pUfn5M5+wwiXXtGCCSk?=
 =?iso-8859-1?Q?boE9ldLQPpHbZQ0klt/sJ0l7zp8Lal5k+Hz1VrHsovN/QW0zSPDKga30qI?=
 =?iso-8859-1?Q?otSzsLxiY7aQPLX/1xNWbJIAxhIij030Wc1qjL4a0JypzC/C1vALrPWFjw?=
 =?iso-8859-1?Q?QXug0pxD1ObXzqU6V9ggMrOBe3cdDt9OpV4MgoF2+vFeaiiqnmREgPdy4Y?=
 =?iso-8859-1?Q?nAWaiMFo8J0mwyBdEld00/jvPcuq2+I8Mpxq+1PWf6qvRNeDBQVmD8F+hF?=
 =?iso-8859-1?Q?mxpUYp4zskteUmQ5KAD1qM5X99ubBxUY42NxnHqVjrKrPmBEpGjiU9/pvB?=
 =?iso-8859-1?Q?hAf0CqnVQdKn2IpJGDay/lfJAx857UK+UJRiwnc0IeQEdgGMiR6hEq+EXE?=
 =?iso-8859-1?Q?AvI7EzVdAGavB2usi7NYeroKAh0AR789+0nleEvk7pBisgYGep7p/7Nh0N?=
 =?iso-8859-1?Q?8krLg3UDqY2usWAWb4OGoz//um1VeTuzEdsGK7emeUlI3nCVGy1pMbTcj5?=
 =?iso-8859-1?Q?NMkokTeDI23Dvd8yMBMrcBq9Ih0ZZ2wJMd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa23eb7-eef5-4312-ac81-08db9ea5d28e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9134.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 22:12:04.3393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0CruKHpLetJpPNskFGDdwWYzDgeeqoWKc0uHPYdWP3HQdZIt9X+PvCQXT7DwdX9/DpBXjV4XYaJPBGNGviBeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7176
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 16 Aug 17:04, Bjorn Helgaas wrote:
>On Wed, Aug 16, 2023 at 02:45:15PM -0700, Saeed Mahameed wrote:
>> On 14 Aug 17:32, Bjorn Helgaas wrote:
>> > On Mon, Aug 14, 2023 at 04:27:20PM +0300, Ilpo Järvinen wrote:
>> > > mlx5_pci_link_toggle() returns mix PCI specific error codes and generic
>> > > errnos.
>> > >
>> > > Convert the PCI specific error values to generic errno using
>> > > pcibios_err_to_errno() before returning them.
>> > >
>> > > Fixes: eabe8e5e88f5 ("net/mlx5: Handle sync reset now event")
>> > > Fixes: 212b4d7251c1 ("net/mlx5: Wait for firmware to enable CRS before pci_restore_state")
>> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> > >
>> > > ---
>> > >
>> > > Maintainers beware, this will conflict with read+write -> set/clear_word
>> > > fixes in pci.git/pcie-rmw. As such, it might be the easiest for Bjorn to
>> > > take it instead of net people.
>> >
>> > I provisionally rebased and applied it on pci/pcie-rmw.  Take a look
>> > and make sure I didn't botch it -- I also found a case in
>> > mlx5_check_dev_ids() that looks like it needs the same conversion.
>> >
>> > The commit as applied is below.
>> >
>> > If networking folks would prefer to take this, let me know and I can
>> > drop it.
>>
>> I Just took this patch into my mlx5 submission queue and sent it to netdev
>> tree, please drop it from your tree.
>
>OK, will do.  Note that this will generate a conflict between netdev
>and the PCI tree during the merge window.
>

In such case let me drop it and you submit it, I was worried it will
conflict with another ongoing feature in mlx5, but I am almost sure it
won't be ready this cycle, so no reason to panic, you can take the patch to
the pci tree and I will revise my PR, it's not too late.

>Bjorn


