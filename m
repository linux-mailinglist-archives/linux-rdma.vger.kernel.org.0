Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C67F564561
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Jul 2022 08:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiGCGYx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 3 Jul 2022 02:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGCGYw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 3 Jul 2022 02:24:52 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2088.outbound.protection.outlook.com [40.92.99.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E28C35
        for <linux-rdma@vger.kernel.org>; Sat,  2 Jul 2022 23:24:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNx+H3m556tSaCQC7BSiUdtFctJoDgrEqQ8PE1WjyrvEcoTvsPerWsTl50X0SXBRlDPk75m0rA+Q8gFpNOoHkBF/TJqHyl0p+Xmn39dvJJke7dJL4tvyUlLQ1xbxolfS9RfYXsiXGKmgdONYD/cLW1cNoOXOZwPUlt1PwWmbJn9n8FXXpkhGOUoFrQAVk6rfmg0+3Kab6w8zZDaE9aU3/5DKnQ93l60+aBVSplvNrlWBhMvn4xRjOR12v6U9KWPSaWSyXHzDrC2svBC1KB9A/7V//XJqLiYJO4LlRM7kxYIsWkbV4h6M1n/Rc91rnHe0wwhw0Qnz5iYEj+UdqPa/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wO3yxbKIQrlANSwDNGXOhj9StpF0oGCcWM0DiEMmrBE=;
 b=NpTbBMokMtBV+ZPT0TE3XT428hxbQoCYKPfdZUc+q/MQwgxkqIaBdEJmvvUG8ARp/CawIRBFP1aTBngLOt0HsOcp9LXneicEW78FwOeP4yIKeAr2wMOybOeTpfIZzh8RVV46OubqtRFqNjE8rYj2P+DL0lkg2ORmMSLnEzr68Y4cs1TqOR77dd1+/PemyDrBrqy+PnlsTPvxK8bOz5KCELySUDccc+ukSKVCB63Z2eiIgxMCCBa0PR6rQ9GnuJ6aU0RiOVlcWrR8P9q1bVl7gp7CVip68beldIXkVu5JRZWhyYT97HV4BNSIRVddE6Ee6kXkpg6evrpAW7waZR2XZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wO3yxbKIQrlANSwDNGXOhj9StpF0oGCcWM0DiEMmrBE=;
 b=rUhNt8l6wfTME2ZaPlFh7axtzr3c4W3LvHQTADH+NlJl3YqYNISxkDCGSJ1tEhfvbKv/QjGno1JITwukdrv2jfwqOvYe/vEb2GgEQhmlteCiDlNQJFxT14M+LyYpl3SZoIlIGGNcWY+dRMheseMWWsEawI1rgtky4cewuP1ZkCJa6FYj498eyncMZ5ldtduF7M0Y+56ZD2Oj0QlLtmLLRNZKU5yQitOWqkjW4+1njO9V0+NNDm0uFOT06qDRrmnaDxU3GKwEF3zfXpE1Exm6TR9DbjLEe46K8c+5cKIQ3wym5BCIXUnGOavOfSyontZOdVlptwa/4CGBTNtS3g3l4Q==
Received: from OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b5::13)
 by TY3P286MB2676.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:257::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Sun, 3 Jul
 2022 06:24:49 +0000
Received: from OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e953:584f:b349:5552]) by OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e953:584f:b349:5552%8]) with mapi id 15.20.5395.019; Sun, 3 Jul 2022
 06:24:49 +0000
Date:   Sun, 3 Jul 2022 14:24:43 +0800
From:   Changcheng Liu <changchengx.liu@outlook.com>
To:     linux-rdma@vger.kernel.org
Subject: resolve addr failed on b2b intefaces on single host
Message-ID: <OSZP286MB1629330CF7EAF7EEDC39E736FEBF9@OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-TMN:  [VRcJbz8chpt0UsmgI5a9m0YO1PUArtg5Yx2r25pXSAHDlAzrXocxPQxq5DKHnsE6vWF/SrKN6wc=]
X-ClientProxiedBy: SG2PR06CA0200.apcprd06.prod.outlook.com (2603:1096:4:1::32)
 To OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b5::13)
X-Microsoft-Original-Message-ID: <20220703062442.GA1765164@jerryopenix>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 573fbf38-32b0-4062-2dd6-08da5cbcbb49
X-MS-TrafficTypeDiagnostic: TY3P286MB2676:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8vLEcQb6s+zGrDhA0TRYyfZ5jpDp/EWHGpgS4zI77EpMS3lGVXA+uOsp8qjrSG0mvg5fmhzHVRWLVL0lGdGA9qxNGsWFIJeAcT/f+g9qAK56bhgoRtGcGCRBW9ydwi68S4n5uWoGgajaheUW1VYvCxIcZLBLv6HlulWY9UmB0PMBYQQjePJH6OQp+DRALp0Spnh/aZrGnmZgvYUzkc1ZpMQQ1YD9dzEI87fl4IAYW3QuwH4Z6ofqBifQlLjwXjXhAGna+SwumMJGUgls0spwTXj2czVs3iDiQhFz/8yMf497Uifyrdm35+choD1aPjG7fV7zvdBXbnBVVuIjr/Qlh4c/iMCNJnJVIRtPT/c0Owa07KRpfkGpCFYN+3WjGUsP2GvQ70ac500cR63K9ErqWRcmA0grSJ18/4CcHDqz1qJr6yrgxgfk9DSMkcQWL+fIyvA6QdJhM2t2tBjLrWfqSVZkhe6Rlkh9s51DJCTbmtXR77eGUAzIjI2N6U4ruQeaq84pNDyAD0o6ZrDhTt2Ef0Z1xBAZNaGZYw9qxkYH5Wpf/JgE73cfJLDkLHuiMEfljNqc1nMvsCxY/hPhOwcJ5xE0rrdfdjbye/LE0sJ21lFaJ5WMLWLb2YdMjq0PcSUcsnEFriI+YVmTuE0wXJ6Rog==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FiOWbFsZMfmJU8N8QSGVt+tjBUdX6PGKkOa6EyCwjSXgHsiDYMANL4OzResK?=
 =?us-ascii?Q?tbjBIBymDFxwb8ycpejLqpXXCDeSwDs1W0UBzFyWUY4GUR2QNRVYlvhgnhkt?=
 =?us-ascii?Q?AJMOnj8hkNTZhvYvfRUE1IWHJIPEpWuwItjJA7o3xdlnZnBDOJ2UR6RBbvPh?=
 =?us-ascii?Q?uiT8cbPIGpYAElLjsr79rbmyfcLLy4j1Dyz/7JJdkx/KThV4z9Hnvljwwx7k?=
 =?us-ascii?Q?bffYNy5HnHMTZB0iGeEqnGsXEPk4H/fTAbmWMmeI+QJsQAkuyY3dcRevb8yO?=
 =?us-ascii?Q?2zpAbmdcmTxNuAkE1VjPOJPWJDetOTK8Xk/vDDbdYB+6byed7CiZ/teAVohp?=
 =?us-ascii?Q?4nB1F+4Z2ewos9BRCNhk8BL88yU0E/EAfg0urPIKkFrAgVIZ63/vNikbSy2F?=
 =?us-ascii?Q?uQIwZX+VDAubwWgeBdZKW5GVQi+mrUGvFLS3f2brar7q0eYzX0prG+dcvyNn?=
 =?us-ascii?Q?DRZa94tlg6oNQmew253WP9ksXqJn/BjkwMe1SQfLMp95z62pgFkbeR2LRi1J?=
 =?us-ascii?Q?KpIp9cZ43tiXlgzJMaK9D39QerkBCvSMW7MvHpVkObox5g80QJRMmm5iDHXa?=
 =?us-ascii?Q?hxy7Wt9mzSSZ0p2OKAQA6VTdkGpmJ/j0yO79lpwX9Dp9B4Lggov0ZjdAQRsJ?=
 =?us-ascii?Q?l9l5GEJBavDAUpiPtKeSQezw5ybM909O/jX6r8h5htRPyxDjMCv9N/2P+ESv?=
 =?us-ascii?Q?erFQnISVATTjVDycrX5F16PoSEKA6f/lDguNMQo9MAMet2JhHaWO1CN9B8mu?=
 =?us-ascii?Q?yLHgWIsZhv+TQZdNzkRfLEjoJQ5OI60uAwQoYV0TGOt73//YwrMAFsmgRjqM?=
 =?us-ascii?Q?dNzIoOPV0sTcbtoe3Vl6HOSEcX8c/qKeYPOH9zlBdGG16rRbbap2hLyEg81H?=
 =?us-ascii?Q?WIts1MXW//0EeDzkObKDHtQcQItVJA4MuJOZPWTc4KqYD6gXsmi/0PS5tnqX?=
 =?us-ascii?Q?Gd+nw0KfyRu+kbAZsD6XjJabQzWc3KbAqXv2H4WQK1mW2sGbTPcqSEEILtrT?=
 =?us-ascii?Q?M5s4zpBoiAyJ2IBHw/dLXaH7FCSRC3i0vc9p84VxBIoufk0CywU11kqfwQ5t?=
 =?us-ascii?Q?0DmCcvkHJVXbIYk2YzvA2GiJ0je0tt0G/T1HYiFay0jCoMrxBlJRB/ip31YL?=
 =?us-ascii?Q?dKcdDx+Ng75ExxRHWxg4/Wz6+AWrcZF4Bveqi9zOxU24fTvW2Ez+Tj8hQn1a?=
 =?us-ascii?Q?XD97qqqBT4uX9EOVcYvace+DCUZmi5uwjSDvMTMpPjrpRPi31OLeteXjzubQ?=
 =?us-ascii?Q?gJAfzdlWJ9A1Fysmt83w2uj1Ect6nRk6ONnOZNLajlSZDF2lG4wZi7DrC4Nz?=
 =?us-ascii?Q?DWxKW18maXlI+dYoY4JS2ibQyIJakT4zclsPmG6X2W7vkwFWdkKtvRksi2O+?=
 =?us-ascii?Q?yElOPz8=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573fbf38-32b0-4062-2dd6-08da5cbcbb49
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 06:24:49.4432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2676
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,
    In one host, there're two RNICs connected back to back.
    src rnic0's ip is 192.168.30.2/24 and dst rnic1's ip is
    192.168.30.4/24.

    Does anyone know why rdma_resolve_addr failed when setting the
    source sockaddr(191.168.30.2) and target sockaddr(192.168.30.4)?

    Example code is here: https://pastecode.io/s/6nc4qx46

B.R.
Changcheng
