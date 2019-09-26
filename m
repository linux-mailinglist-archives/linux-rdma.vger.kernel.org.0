Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6D31BF898
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 19:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfIZR6l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Sep 2019 13:58:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbfIZR6l (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Sep 2019 13:58:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 451138980E5;
        Thu, 26 Sep 2019 17:58:41 +0000 (UTC)
Received: from jtoppins.rdu.csb (ovpn-125-21.rdu2.redhat.com [10.10.125.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 001685C220;
        Thu, 26 Sep 2019 17:58:38 +0000 (UTC)
Reply-To: jtoppins@redhat.com
Subject: Re: [PATCH rdma-core] kernel-boot: Tighten check if device is virtual
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20190926094253.31145-1-leon@kernel.org>
 <20190926123427.GD19509@mellanox.com>
From:   Jonathan Toppins <jtoppins@redhat.com>
Organization: Red Hat
Message-ID: <9c582ae3-8214-f9b8-d403-cf443b70284e@redhat.com>
Date:   Thu, 26 Sep 2019 13:58:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190926123427.GD19509@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Thu, 26 Sep 2019 17:58:41 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 09/26/2019 08:34 AM, Jason Gunthorpe wrote:
> On Thu, Sep 26, 2019 at 12:42:53PM +0300, Leon Romanovsky wrote:
>> From: Leon Romanovsky <leonro@mellanox.com>
>>
>> Virtual devices like SIW or RXE don't set FW version because
>> they don't have one, use that fact to rely on having empty
>> fw_ver file to sense such virtual devices.
> 
> Have you checked that every physical device does set fw version?
> 
> Seems hacky

agreed, how are tuntap devices handled, is there a similar handling that
can be applied here?

