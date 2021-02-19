Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC0B31FA6C
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Feb 2021 15:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBSONi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Feb 2021 09:13:38 -0500
Received: from p3plsmtpa08-10.prod.phx3.secureserver.net ([173.201.193.111]:57680
        "EHLO p3plsmtpa08-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230014AbhBSONc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Feb 2021 09:13:32 -0500
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id D6WLlXAwlOhTrD6WRl6LtU; Fri, 19 Feb 2021 07:12:45 -0700
X-CMAE-Analysis: v=2.4 cv=TJGA93pa c=1 sm=1 tr=0 ts=602fc75d
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=NcAdmkYbkJ8ibZaaXeAA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: directing soft iWARP traffic through a secure tunnel
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
References: <20210216180946.GV4718@ziepe.ca>
 <61EFD7EA-FA16-4AA1-B92F-0B0D4CC697AB@oracle.com>
 <OFA2194C43.CE483827-ON0025867E.004018CA-0025867E.004470FA@notes.na.collabserv.com>
 <OF3B04E71D.E72E1A4D-ON00258681.004164EA-00258681.00480051@notes.na.collabserv.com>
 <20210219135728.GD2643399@ziepe.ca>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <bf7a73c3-ba50-a836-8e01-87c4183f003e@talpey.com>
Date:   Fri, 19 Feb 2021 09:12:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210219135728.GD2643399@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfH8pyOpYBAnfZtbTWoo5qpzKXrpaS0fRV/SozAwfT2twP7c9xiVLgzXVYsi21K5esknhSZhokRwoe77oYcg+ZgOaTHL2G5mJeABqZIhdTM2Au2dEWXsC
 HTn94aSPiNEAa7MrmowZQhZpeU7R/cGLepqo2I0wz1tFzWgzJI+iO5SOwdMCdnHibCguHjFtSMQ2Unoj7avDMiTsDrJoWT0bPM7d482E7/rgkYAOTt3HLsd1
 o3rBAGWJrQHT+CEybepGqoTuF/AoeAfQ1CktK10P2qr31TcWvP/wyy9YenoPhVJbIpePt7ewymPEMGWUirXQrg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/19/2021 8:57 AM, Jason Gunthorpe wrote:
> On Fri, Feb 19, 2021 at 01:06:26PM +0000, Bernard Metzler wrote:
> 
>> Actually, all this GID and GUID and friends for iWARP
>> CM looks more like squeezing things into InfiniBand terms,
>> where we could just rely on plain ARP and IP
>> (ARP resolve interface, see if there is an RDMA device
>> bound to, done)... or do I miss something?
> 
> I don't know how iWarp cM works very well, it would not be surprising
> if the gid table code has gained general rocee behaviors that are not
> applicable to iwarp modes.

iWarp doesn't really need a CM, it is capable of peer-to-peer without
any need to assign connection and queuepair ID's. The CM infrastructure
basically just implements a state machine to allow upper layers to have
a consistent connection API.

I'm with Bernard here, forcing iWarp to use CM is a fairly unnatural
act. Assigning a GID/GUID is unnecessary from a protocol perspective.

Tom.

> With Steve gone I don't think there is really anyone left that even
> really knows how the iWarp stuff works??
> 
> Jason
> 
