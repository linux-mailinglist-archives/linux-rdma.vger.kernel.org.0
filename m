Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F9F1F3700
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2020 11:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgFIJVR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jun 2020 05:21:17 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:22682 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgFIJVQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Jun 2020 05:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591694476; x=1623230476;
  h=subject:to:references:cc:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=nF9G0uIp0EqGaKlZRruPKwDafn+ACllof9PIxrZN6/Y=;
  b=KdOx0vwoMxhR9DODJVQ1ownvGzmPse1REkJQ/naWeb6daA1KgzqceOVg
   qCbxk71W5oWSRuchsgCoZv3RKlaC6pyYtIFcuOwWt1gdTFYMUcUHgCjWa
   LK7/O9fBNR9EWiMbtmSDiBdPvb9TNrR4AtKijRmxLG3pWvwaEffSHkFCB
   Q=;
IronPort-SDR: lXQrI3dOyTOwIeEUHA0t5OQPZQHBtdrrnJhjqQny6iAR5hZ+rxBGYc5gOOZpO4d5KxTABwZVmL
 ewF9BgQddWYA==
X-IronPort-AV: E=Sophos;i="5.73,491,1583193600"; 
   d="scan'208";a="35243491"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 09 Jun 2020 09:21:15 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id 26B6DA0681;
        Tue,  9 Jun 2020 09:21:11 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 9 Jun 2020 09:21:08 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.145) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 9 Jun 2020 09:21:03 +0000
Subject: Re: [PATCH 1/1] RDMA/core: Don't copy uninitialized stack memory to
 userspace
To:     Xidong Wang <wangxidong_97@163.com>
References: <1591692057-46380-1-git-send-email-wangxidong_97@163.com>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Yishai Hadas" <yishaih@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <844cee99-5f52-3110-02b2-60b205f1a189@amazon.com>
Date:   Tue, 9 Jun 2020 12:20:57 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <1591692057-46380-1-git-send-email-wangxidong_97@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.145]
X-ClientProxiedBy: EX13D13UWB001.ant.amazon.com (10.43.161.156) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 09/06/2020 11:40, Xidong Wang wrote:
> From: xidongwang <wangxidong_97@163.com>
> 
> ib_uverbs_create_ah() may copy stack allocated
> structs to userspace without initializing all members of these
> structs. Clear out this memory to prevent information leaks.

Which members are not initialized?
