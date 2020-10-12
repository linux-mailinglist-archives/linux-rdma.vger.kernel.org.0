Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882AF28AFD2
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 10:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgJLINr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 04:13:47 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:4366 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728130AbgJLINn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Oct 2020 04:13:43 -0400
X-IronPort-AV: E=Sophos;i="5.77,366,1596470400"; 
   d="scan'208";a="100071486"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 12 Oct 2020 16:13:41 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id D41F348990C1
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 16:13:37 +0800 (CST)
Received: from [10.167.225.206] (10.167.225.206) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 12 Oct 2020 16:13:39 +0800
From:   "Li, Hao" <lihao2018.fnst@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
Subject: Question about supporting RDMA Extensions for PMEM
Message-ID: <8b3c3c81-c0fd-adb2-52a9-94c73aac7e37@cn.fujitsu.com>
Date:   Mon, 12 Oct 2020 16:13:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.167.225.206]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: D41F348990C1.A8BC8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lihao2018.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

I have noticed that IETF has released a draft of RDMA Extensions for
PMEM [1]. Does libibverbs has a plan to implement these extensions? Are
there some good starting points if we want to participate the development.
Thanks!

[1]: https://tools.ietf.org/id/draft-talpey-rdma-commit-01.html

Regards,
Hao Li


