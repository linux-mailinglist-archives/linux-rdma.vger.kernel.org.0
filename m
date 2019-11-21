Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1E9104979
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 04:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbfKUD50 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Nov 2019 22:57:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60227 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725842AbfKUD50 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Nov 2019 22:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574308645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=snqW+q0nXEln1f+D4QvCQZQ5aoIIekZZLEDjLMQzHp0=;
        b=CRo3ii0C574C3YOYZP3c5DSabbDq9JJso9k2VSv4O2qAgiQgicKg4VX4uG2cq2IU44ZoZC
        psUsReRw8gZsucPmlLqD4SBAm1VoDGsxA3FliYTv+xyQ3malk0KZLM118fMSWI2IvWO2W+
        k8+MO8l3nfsK6LZ0arcN7r7ElPpSdMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-3kLdis7FN5W2FgTJdPFzYQ-1; Wed, 20 Nov 2019 22:57:24 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FFCA800054;
        Thu, 21 Nov 2019 03:57:22 +0000 (UTC)
Received: from [10.72.12.204] (ovpn-12-204.pek2.redhat.com [10.72.12.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B318C5D72A;
        Thu, 21 Nov 2019 03:57:11 +0000 (UTC)
Subject: Re: [net-next v2 1/1] virtual-bus: Implementation of Virtual Bus
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Parav Pandit <parav@mellanox.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        Dave Ertman <david.m.ertman@intel.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, nhorman@redhat.com,
        sassmann@redhat.com, Kiran Patil <kiran.patil@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Tiwei Bie <tiwei.bie@intel.com>
References: <20191115223355.1277139-1-jeffrey.t.kirsher@intel.com>
 <AM0PR05MB4866CF61828A458319899664D1700@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <a40c09ee-0915-f10c-650e-7539726a887b@redhat.com>
 <AM0PR05MB4866C40A177D3D60BFC558F7D14C0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <13946106-dab2-6bbe-df79-ca6dfdeb4c51@redhat.com>
 <AM0PR05MB486685F7C839AD8A5F3EEA91D14C0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <ead356f5-db81-cb01-0d74-b9e34965a20f@redhat.com>
 <20191119164632.GA4991@ziepe.ca>
 <1655636323.35622504.1574220291482.JavaMail.zimbra@redhat.com>
 <20191120133349.GB22515@ziepe.ca>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <68837419-1306-7c61-a4d1-081f1fb78992@redhat.com>
Date:   Thu, 21 Nov 2019 11:57:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191120133349.GB22515@ziepe.ca>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 3kLdis7FN5W2FgTJdPFzYQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2019/11/20 =E4=B8=8B=E5=8D=889:33, Jason Gunthorpe wrote:
> On Tue, Nov 19, 2019 at 10:24:51PM -0500, Jason Wang wrote:
>
>>> The driver providing the virtio should really be in control of the
>>> life cycle policy. For net related virtio that is clearly devlink.
>> As replied in another thread, there were already existed devices
>> (Intel IFC VF) that doesn't use devlink.
> Why is that a justification? Drivers can learn to use devlink, it
> isn't like it is set in stone.


Technically, I fully agree. But vendors has their right to to other way=20
unless devlink is forced when creating netdevice.

Thanks


>
> Jason
>

