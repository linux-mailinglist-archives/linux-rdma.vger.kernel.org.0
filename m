Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E676D3BD8AD
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jul 2021 16:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhGFOqB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jul 2021 10:46:01 -0400
Received: from m12-14.163.com ([220.181.12.14]:35916 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232909AbhGFOpu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Jul 2021 10:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=EuJBX
        1ZKoj+1ARbmlA1rHu7TnjQoW4QVhjscbi7p+OY=; b=YRmMTPV5WUXDJP+XfmyyS
        uJVU+uAz84Adzu8jDitNO3xMwAkJ/Gw7i9A4EwDfhon0E4YLLBVlR+TpwcqYvXTI
        /1WBUkVRr96lZy51C3z2ggff0/JMaQVef/Jz7Y+gAWHfdBJCvGawnOxncUOSyKBN
        Bgd7F+WxKzsZ7pDFMl71oI=
Received: from [192.168.0.11] (unknown [183.210.50.1])
        by smtp10 (Coremail) with SMTP id DsCowABHTjK8Z+RgxK8mSg--.63950S2;
        Tue, 06 Jul 2021 22:25:01 +0800 (CST)
From:   Xiao Yang <ice_yangxiao@163.com>
Subject: Question about ibv_reg_mr() and ibv_reg_mr_iova()
To:     jgg@nvidia.com, rpearsonhpe@gmail.com, haakon.bugge@oracle.com,
        zyjzyj2000@gmail.com
Cc:     linux-rdma@vger.kernel.org
Message-ID: <56061c0b-89bc-4ca1-599b-c47ce9a5e5f7@163.com>
Date:   Tue, 6 Jul 2021 22:25:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: DsCowABHTjK8Z+RgxK8mSg--.63950S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUDwFxDUUUU
X-Originating-IP: [183.210.50.1]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/xtbBEgnHXl6iclDQggABsP
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

After reading the implementation of ibv_reg_mr() and ibv_reg_mr_iova(), 
I am confused about three variables(i.e. addr, iova, hca_va).

What do these three variables mean? what is the difference between them?

Best Regards,

Xiao Yang

