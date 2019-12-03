Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 131F610F44F
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2019 01:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfLCA7H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Dec 2019 19:59:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35586 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725899AbfLCA7H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Dec 2019 19:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575334746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DJsbufhtBhVAM9akbCFhx8OR37KN18Pkh0f3aJ/wr48=;
        b=Ino9xIkzmEb9DHkvfwl6hvT8TMRg7FxvCDLcN/ReYqwcgwP7xLVuZATO8bEwJnfBmv3DVm
        IIUaMtNs6BtxAKVs9d/HdcF+Ux88Gd6Ft7C5iVzKGKT86xAjeJoiJ15s07IeqHXFbIIBO8
        JW1DWOgAeBCTMcKLLc3c5XMkN7xA9Mw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-id8hnlJZMgy_H_WpJIWsrQ-1; Mon, 02 Dec 2019 19:59:02 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A00E800D41;
        Tue,  3 Dec 2019 00:59:01 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D658619C68;
        Tue,  3 Dec 2019 00:58:53 +0000 (UTC)
Date:   Tue, 3 Dec 2019 08:58:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Stephen Rust <srust@blockbridge.com>
Cc:     Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
Message-ID: <20191203005849.GB25002@ming.t460p>
References: <CAAFE1bd9wuuobpe4VK7Ty175j7mWT+kRmHCNhVD+6R8MWEAqmw@mail.gmail.com>
 <20191128015748.GA3277@ming.t460p>
 <CA+VdTb_-CGaPjKUQteKVFSGqDz-5o-tuRRkJYqt8B9iOQypiwQ@mail.gmail.com>
 <20191128025822.GC3277@ming.t460p>
 <CAAFE1bfsXsKGyw7SU_z4NanT+wmtuJT=XejBYbHHMCDQwm73sw@mail.gmail.com>
 <20191128091210.GC15549@ming.t460p>
 <CAAFE1beMkvyRctGqpffd3o_QtDH0CrmQSb=fV4GzqMUXWzPyOw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAFE1beMkvyRctGqpffd3o_QtDH0CrmQSb=fV4GzqMUXWzPyOw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: id8hnlJZMgy_H_WpJIWsrQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 02, 2019 at 01:42:15PM -0500, Stephen Rust wrote:
> Hi Ming,
>=20
> > I may get one machine with Mellanox NIC, is it easy to setup & reproduc=
e
> > just in the local machine(both host and target are setup on same machin=
e)?
>=20
> Yes, I have reproduced locally on one machine (using the IP address of
> the Mellanox NIC as the target IP), with iser enabled on the target,
> and iscsiadm connected via iser.
>=20
> e.g.:
> target:
> /iscsi/iqn.20.../0.0.0.0:3260> enable_iser true
> iSER enable now: True
>=20
>   | |   o- portals
> .........................................................................=
...........................
> [Portals: 1]
>   | |     o- 0.0.0.0:3260
> .........................................................................=
..........................
> [iser]
>=20
> client:
> # iscsiadm -m node -o update --targetname <target> -n
> iface.transport_name -v iser
> # iscsiadm -m node --targetname <target> --login
> # iscsiadm -m session
> iser: [3] 172.16.XX.XX:3260,1
> iqn.2003-01.org.linux-iscsi.x8664:sn.c46c084919b0 (non-flash)
>=20
> > Please try to trace bio_add_page() a bit via 'bpftrace ./ilo.bt'.
>=20
> Here is the output of this trace from a failed run:
>=20
> # bpftrace lio.bt
> modprobe: FATAL: Module kheaders not found.
> Attaching 3 probes...
> 512 76
> 4096 0
> 4096 0
> 4096 0
> 4096 76

The above buffer might be the reason, 4096 is length, and 76 is the
offset, that means the added buffer crosses two pages, meantime the
buffer isn't aligned.

We need to figure out why the magic 76 offset is passed from target or
driver.

Please install bcc and collect the following log:

/usr/share/bcc/tools/trace -K 'bio_add_page ((arg4 & 512) !=3D 0) "%d %d", =
arg3, arg4 '


Thanks,
Ming

