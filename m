Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9211D143B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 15:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387480AbgEMNNY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 09:13:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57286 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733282AbgEMNNY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 May 2020 09:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589375603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kC/Pwa8f1gD3R5LYjYmzPSPuGCXjungEBXbTdD/3zMQ=;
        b=BT6xvsXMs+UKhUAT1LQd6PjK7dOFOjjV34X3krLGkNiE7qRg2LS3Lg6++7VvoBNMW6P4Dl
        II4cimXWFINDdz8SRPJSnckMuVCJyK+7W8IDibEiU/SxmVmpH5WPLQ2M2P1hrA1DN/7FFd
        WIB6ZjDtupAASQjS04XFR8IQXtJ90+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-j5Rv_ovSOqaPeCLkWE73pQ-1; Wed, 13 May 2020 09:13:21 -0400
X-MC-Unique: j5Rv_ovSOqaPeCLkWE73pQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AED3780183C;
        Wed, 13 May 2020 13:13:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-59.rdu2.redhat.com [10.10.112.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 800786A960;
        Wed, 13 May 2020 13:13:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200513062649.2100053-30-hch@lst.de>
References: <20200513062649.2100053-30-hch@lst.de> <20200513062649.2100053-1-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
        target-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        drbd-dev@lists.linbit.com, linux-cifs@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org,
        cluster-devel@redhat.com, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
        linux-kernel@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>,
        Ying Xue <ying.xue@windriver.com>, ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH 29/33] rxrpc_sock_set_min_security_level
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3123533.1589375587.1@warthog.procyon.org.uk>
Date:   Wed, 13 May 2020 14:13:07 +0100
Message-ID: <3123534.1589375587@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> +int rxrpc_sock_set_min_security_level(struct sock *sk, unsigned int val);
> +

Looks good - but you do need to add this to Documentation/networking/rxrpc.txt
also, thanks.

David

