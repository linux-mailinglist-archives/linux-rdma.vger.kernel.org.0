Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F152C89EF1
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 14:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfHLM4d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 12 Aug 2019 08:56:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49866 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726219AbfHLM4c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Aug 2019 08:56:32 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7CCpuUE107112
        for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2019 08:56:28 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ub5ux601v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2019 08:56:28 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 12 Aug 2019 12:56:27 -0000
Received: from us1a3-smtp06.a3.dal06.isc4sb.com (10.146.103.243)
        by smtp.notes.na.collabserv.com (10.106.227.158) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 12 Aug 2019 12:56:19 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp06.a3.dal06.isc4sb.com
          with ESMTP id 2019081212561842-400162 ;
          Mon, 12 Aug 2019 12:56:18 +0000 
In-Reply-To: <20190812095802.GA16978@chelsio.com>
Subject: Re: [PATCH for-rc] siw: MPA Reply handler tries to read beyond MPA message
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Krishnamraju Eraparaju" <krishna2@chelsio.com>
Cc:     "Tom Talpey" <tom@talpey.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Potnuri Bharat Teja" <bharat@chelsio.com>,
        "Nirranjan Kirubaharan" <nirranjan@chelsio.com>
Date:   Mon, 12 Aug 2019 12:56:18 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190812095802.GA16978@chelsio.com>,<20190805172605.GA5549@chelsio.com>
 <8499b96a-48dd-1286-ea0f-e66be34afffa@talpey.com>
 <20190731103310.23199-1-krishna2@chelsio.com>
 <OF4DB6F345.7C76F976-ON00258449.00392FF3-00258449.003C1BFB@notes.na.collabserv.com>
 <OF95C29EF7.244FC9E1-ON0025844A.003D049F-0025844A.003E229B@notes.na.collabserv.com>
 <518b1734-5d72-e32d-376b-0fec1cbce8f5@talpey.com>
 <OF7F439620.B43AE37C-ON00258450.00524237-00258450.0052DFDC@notes.na.collabserv.com>
 <OF5309F939.D7FB77B5-ON00258451.002EE699-00258451.0039A86F@notes.na.collabserv.com>
 <OF748C7EEE.1CA3CB7C-ON00258451.004B1A16-00258451.004C38AC@notes.na.collabserv.com>
 <1043a512-68c6-c263-7589-5da4b9a9e282@talpey.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 21635
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19081212-1335-0000-0000-000000FB6006
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.263141
X-IBM-SpamModules-Versions: BY=3.00011585; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01245739; UDB=6.00657338; IPR=6.01027242;
 MB=3.00028143; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-12 12:56:24
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-12 09:21:43 - 6.00010276
x-cbparentid: 19081212-1336-0000-0000-000001DF6597
Message-Id: <OF61AD8759.AF34F1D4-ON00258454.00462285-00258454.004712D9@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>Date: 08/12/2019 11:59AM
>Cc: "Tom Talpey" <tom@talpey.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
>"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "Potnuri
>Bharat Teja" <bharat@chelsio.com>, "Nirranjan Kirubaharan"
><nirranjan@chelsio.com>
>Subject: [EXTERNAL] Re: [PATCH for-rc] siw: MPA Reply handler tries
>to read beyond MPA message
>
>On Saturday, August 08/10/19, 2019 at 02:05:00 +0530, Tom Talpey
>wrote:
>> On 8/9/2019 9:52 AM, Bernard Metzler wrote:
>> > -----"Tom Talpey" <tom@talpey.com> wrote: -----
>> > 
>> >> To: "Bernard Metzler" <BMT@zurich.ibm.com>, "Krishnamraju
>Eraparaju"
>> >> <krishna2@chelsio.com>
>> >> From: "Tom Talpey" <tom@talpey.com>
>> >> Date: 08/09/2019 02:27PM
>> >> Cc: "jgg@ziepe.ca" <jgg@ziepe.ca>, "linux-rdma@vger.kernel.org"
>> >> <linux-rdma@vger.kernel.org>, "Potnuri Bharat Teja"
>> >> <bharat@chelsio.com>, "Nirranjan Kirubaharan"
><nirranjan@chelsio.com>
>> >> Subject: [EXTERNAL] Re: [PATCH for-rc] siw: MPA Reply handler
>tries
>> >> to read beyond MPA message
>> >>
>> >> On 8/9/2019 6:29 AM, Bernard Metzler wrote:
>> >>> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote:
>-----
>> >>>
>> >>>> To: "Bernard Metzler" <BMT@zurich.ibm.com>
>> >>>> From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>> >>>> Date: 08/08/2019 06:47PM
>> >>>> Cc: "Tom Talpey" <tom@talpey.com>, "jgg@ziepe.ca"
><jgg@ziepe.ca>,
>> >>>> "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
>> >> "Potnuri
>> >>>> Bharat Teja" <bharat@chelsio.com>, "Nirranjan Kirubaharan"
>> >>>> <nirranjan@chelsio.com>
>> >>>> Subject: [EXTERNAL] Re: [PATCH for-rc] siw: MPA Reply handler
>> >> tries
>> >>>> to read beyond MPA message
>> >>>>
>> >>>> On Thursday, August 08/08/19, 2019 at 15:05:12 +0000, Bernard
>> >> Metzler
>> >>>> wrote:
>> >>>>> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote:
>-----
>> >>>>>
>> >>>>>> To: "Tom Talpey" <tom@talpey.com>, <BMT@zurich.ibm.com>
>> >>>>>> From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>> >>>>>> Date: 08/05/2019 07:26PM
>> >>>>>> Cc: "jgg@ziepe.ca" <jgg@ziepe.ca>,
>"linux-rdma@vger.kernel.org"
>> >>>>>> <linux-rdma@vger.kernel.org>, "Potnuri Bharat Teja"
>> >>>>>> <bharat@chelsio.com>, "Nirranjan Kirubaharan"
>> >>>> <nirranjan@chelsio.com>
>> >>>>>> Subject: [EXTERNAL] Re: [PATCH for-rc] siw: MPA Reply
>handler
>> >>>> tries
>> >>>>>> to read beyond MPA message
>> >>>>>>
>> >>>>>> On Friday, August 08/02/19, 2019 at 18:17:37 +0530, Tom
>Talpey
>> >>>> wrote:
>> >>>>>>> On 8/2/2019 7:18 AM, Bernard Metzler wrote:
>> >>>>>>>> -----"Tom Talpey" <tom@talpey.com> wrote: -----
>> >>>>>>>>
>> >>>>>>>>> To: "Bernard Metzler" <BMT@zurich.ibm.com>, "Krishnamraju
>> >>>>>> Eraparaju"
>> >>>>>>>>> <krishna2@chelsio.com>
>> >>>>>>>>> From: "Tom Talpey" <tom@talpey.com>
>> >>>>>>>>> Date: 08/01/2019 08:54PM
>> >>>>>>>>> Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
>> >>>>>> bharat@chelsio.com,
>> >>>>>>>>> nirranjan@chelsio.com, krishn2@chelsio.com
>> >>>>>>>>> Subject: [EXTERNAL] Re: [PATCH for-rc] siw: MPA Reply
>handler
>> >>>>>> tries
>> >>>>>>>>> to read beyond MPA message
>> >>>>>>>>>
>> >>>>>>>>> On 8/1/2019 6:56 AM, Bernard Metzler wrote:
>> >>>>>>>>>> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com>
>wrote:
>> >>>>>> -----
>> >>>>>>>>>>
>> >>>>>>>>>>> To: jgg@ziepe.ca, bmt@zurich.ibm.com
>> >>>>>>>>>>> From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>> >>>>>>>>>>> Date: 07/31/2019 12:34PM
>> >>>>>>>>>>> Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com,
>> >>>>>>>>>>> nirranjan@chelsio.com, krishn2@chelsio.com,
>"Krishnamraju
>> >>>>>>>>> Eraparaju"
>> >>>>>>>>>>> <krishna2@chelsio.com>
>> >>>>>>>>>>> Subject: [EXTERNAL] [PATCH for-rc] siw: MPA Reply
>handler
>> >>>>>> tries to
>> >>>>>>>>>>> read beyond MPA message
>> >>>>>>>>>>>
>> >>>>>>>>>>> while processing MPA Reply, SIW driver is trying to
>read
>> >>>> extra
>> >>>>>> 4
>> >>>>>>>>>>> bytes
>> >>>>>>>>>>> than what peer has advertised as private data length.
>> >>>>>>>>>>>
>> >>>>>>>>>>> If a FPDU data is received before even
>siw_recv_mpa_rr()
>> >>>>>> completed
>> >>>>>>>>>>> reading MPA reply, then ksock_recv() in
>siw_recv_mpa_rr()
>> >>>>>> could
>> >>>>>>>>> also
>> >>>>>>>>>>> read FPDU, if "size" is larger than advertised MPA
>reply
>> >>>>>> length.
>> >>>>>>>>>>>
>> >>>>>>>>>>> 501 static int siw_recv_mpa_rr(struct siw_cep *cep)
>> >>>>>>>>>>> 502 {
>> >>>>>>>>>>>              .............
>> >>>>>>>>>>> 572
>> >>>>>>>>>>> 573         if (rcvd > to_rcv)
>> >>>>>>>>>>> 574                 return -EPROTO;   <----- Failure
>here
>> >>>>>>>>>>>
>> >>>>>>>>>>> Looks like the intention here is to throw an ERROR if
>the
>> >>>>>> received
>> >>>>>>>>>>> data
>> >>>>>>>>>>> is more than the total private data length advertised
>by
>> >>>> the
>> >>>>>> peer.
>> >>>>>>>>>>> But
>> >>>>>>>>>>> reading beyond MPA message causes siw_cm to generate
>> >>>>>>>>>>> RDMA_CM_EVENT_CONNECT_ERROR event when TCP socket recv
>> >>>> buffer
>> >>>>>> is
>> >>>>>>>>>>> already
>> >>>>>>>>>>> queued with FPDU messages.
>> >>>>>>>>>>>
>> >>>>>>>>>>> Hence, this function should only read upto private data
>> >>>>>> length.
>> >>>>>>>>>>>
>> >>>>>>>>>>> Signed-off-by: Krishnamraju Eraparaju
>> >>>> <krishna2@chelsio.com>
>> >>>>>>>>>>> ---
>> >>>>>>>>>>> drivers/infiniband/sw/siw/siw_cm.c | 4 ++--
>> >>>>>>>>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>> >>>>>>>>>>>
>> >>>>>>>>>>> diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>> >>>>>>>>>>> b/drivers/infiniband/sw/siw/siw_cm.c
>> >>>>>>>>>>> index a7cde98e73e8..8dc8cea2566c 100644
>> >>>>>>>>>>> --- a/drivers/infiniband/sw/siw/siw_cm.c
>> >>>>>>>>>>> +++ b/drivers/infiniband/sw/siw/siw_cm.c
>> >>>>>>>>>>> @@ -559,13 +559,13 @@ static int siw_recv_mpa_rr(struct
>> >>>>>> siw_cep
>> >>>>>>>>> *cep)
>> >>>>>>>>>>> 	 * A private data buffer gets allocated if
>> >>>> hdr->params.pd_len
>> >>>>>> !=
>> >>>>>>>>> 0.
>> >>>>>>>>>>> 	 */
>> >>>>>>>>>>> 	if (!cep->mpa.pdata) {
>> >>>>>>>>>>> -		cep->mpa.pdata = kmalloc(pd_len + 4, GFP_KERNEL);
>> >>>>>>>>>>> +		cep->mpa.pdata = kmalloc(pd_len, GFP_KERNEL);
>> >>>>>>>>>>> 		if (!cep->mpa.pdata)
>> >>>>>>>>>>> 			return -ENOMEM;
>> >>>>>>>>>>> 	}
>> >>>>>>>>>>> 	rcvd = ksock_recv(
>> >>>>>>>>>>> 		s, cep->mpa.pdata + cep->mpa.bytes_rcvd -
>sizeof(struct
>> >>>>>> mpa_rr),
>> >>>>>>>>>>> -		to_rcv + 4, MSG_DONTWAIT);
>> >>>>>>>>>>> +		to_rcv, MSG_DONTWAIT);
>> >>>>>>>>>>>
>> >>>>>>>>>>> 	if (rcvd < 0)
>> >>>>>>>>>>> 		return rcvd;
>> >>>>>>>>>>> -- 
>> >>>>>>>>>>> 2.23.0.rc0
>> >>>>>>>>>>>
>> >>>>>>>>>>>
>> >>>>>>>>>>
>> >>>>>>>>>> The intention of this code is to make sure the
>> >>>>>>>>>> peer does not violates the MPA handshake rules.
>> >>>>>>>>>> The initiator MUST NOT send extra data after its
>> >>>>>>>>>> MPA request and before receiving the MPA reply.
>> >>>>>>>>>
>> >>>>>>>>> I think this is true only for MPA v2. With MPA v1, the
>> >>>>>>>>> initiator can begin sending immediately (before receiving
>> >>>>>>>>> the MPA reply), because there is no actual negotiation at
>> >>>>>>>>> the MPA layer.
>> >>>>>>>>>
>> >>>>>>>>> With MPA v2, the negotiation exchange is required because
>> >>>>>>>>> the type of the following message is predicated by the
>> >>>>>>>>> "Enhanced mode" a|b|c|d flags present in the first 32
>bits
>> >>>>>>>>> of the private data buffer.
>> >>>>>>>>>
>> >>>>>>>>> So, it seems to me that additional logic is needed here
>to
>> >>>>>>>>> determine the MPA version, before sniffing additional
>octets
>> >>>>>>>> >from the incoming stream?
>> >>>>>>>>>
>> >>>>>>>>> Tom.
>> >>>>>>>>>
>> >>>>>>>>
>> >>>>>>>> There still is the marker negotiation taking place.
>> >>>>>>>> RFC 5044 says in section 7.1.2:
>> >>>>>>>>
>> >>>>>>>> "Note: Since the receiver's ability to deal with Markers
>is
>> >>>>>>>>     unknown until the Request and Reply Frames have been
>> >>>>>>>>     received, sending FPDUs before this occurs is not
>> >> possible."
>> >>>>>>>>
>> >>>>>>>> This section further discusses the responder's behavior,
>> >>>>>>>> where it MUST receive a first FPDU from the initiator
>> >>>>>>>> before sending its first FPDU:
>> >>>>>>>>
>> >>>>>>>> "4.  MPA Responder mode implementations MUST receive and
>> >>>> validate
>> >>>>>> at
>> >>>>>>>>           least one FPDU before sending any FPDUs or
>Markers."
>> >>>>>>>>
>> >>>>>>>> So it appears with MPA version 1, the current siw
>> >>>>>>>> code is correct. The initiator is entering FPDU mode
>> >>>>>>>> first, and only after receiving the MPA reply frame.
>> >>>>>>>> Only after the initiator sent a first FPDU, the responder
>> >>>>>>>> can start using the connection in FPDU mode.
>> >>>>>>>> Because of this somehow broken connection establishment
>> >>>>>>>> procedure (only the initiator can start sending data), a
>> >>>>>>>> later MPA version makes this first FPDU exchange explicit
>> >>>>>>>> and selectable (zero length READ/WRITE/Send).
>> >>>>>>>
>> >>>>>>> Yeah, I guess so. Because nobody ever actually implemented
>> >>>> markers,
>> >>>>>>> I think that they may more or less passively ignore this.
>But
>> >>>>>> you're
>> >>>>>>> currect that it's invalid protocol behavior.
>> >>>>>>>
>> >>>>>>> If your testing didn't uncover any issues with existing
>> >>>>>> implementations
>> >>>>>>> failing to connect with your strict checking, I'm ok with
>it.
>> >>>>>> Tom & Bernard,
>> >>>>>> Thanks for the insight on MPA negotiation.
>> >>>>>>
>> >>>>>> Could the below patch be considered as a proper fix?
>> >>>>>>
>> >>>>>> diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>> >>>>>> b/drivers/infiniband/sw/siw/siw_cm.c
>> >>>>>> index 9ce8a1b925d2..0aec1b5212f9 100644
>> >>>>>> --- a/drivers/infiniband/sw/siw/siw_cm.c
>> >>>>>> +++ b/drivers/infiniband/sw/siw/siw_cm.c
>> >>>>>> @@ -503,6 +503,7 @@ static int siw_recv_mpa_rr(struct
>siw_cep
>> >>>> *cep)
>> >>>>>>          struct socket *s = cep->sock;
>> >>>>>>          u16 pd_len;
>> >>>>>>          int rcvd, to_rcv;
>> >>>>>> +       int extra_data_check = 4; /* 4Bytes, for MPA rules
>> >>>> violation
>> >>>>>> checking */
>> >>>>>>
>> >>>>>>          if (cep->mpa.bytes_rcvd < sizeof(struct mpa_rr)) {
>> >>>>>>                  rcvd = ksock_recv(s, (char *)hdr +
>> >>>>>> cep->mpa.bytes_rcvd,
>> >>>>>> @@ -553,23 +554,37 @@ static int siw_recv_mpa_rr(struct
>siw_cep
>> >>>> *cep)
>> >>>>>>                  return -EPROTO;
>> >>>>>>          }
>> >>>>>>
>> >>>>>> +       /*
>> >>>>>> +        * Peer must not send any extra data other than MPA
>> >>>> messages
>> >>>>>> until MPA
>> >>>>>> +        * negotiation is completed, an exception is MPA V2
>> >>>>>> client-server Mode,
>> >>>>>> +        * IE, in this mode the peer after sending MPA Reply
>can
>> >>>>>> immediately
>> >>>>>> +        * start sending data in RDMA mode.
>> >>>>>> +        */
>> >>>>>
>> >>>>> This is unfortunately not true. The responder NEVER sends
>> >>>>> an FPDU without having seen an FPDU from the initiator.
>> >>>>> I just checked RFC 6581 again. The RTR (ready-to-receive)
>> >>>>> indication from the initiator is still needed, but now
>> >>>>> provided by the protocol and not the application: w/o
>> >>>>> 'enhanced MPA setup', the initiator sends the first
>> >>>>> FPDU as an application message. With 'enhanced MPA setup',
>> >>>>> the initiator protocol entity sends (w/o application
>> >>>>> interaction) a zero length READ/WRITE/Send as a first FPDU,
>> >>>>> as previously negotiated with the responder. Again: only
>> >>>>> after the responder has seen the first FPDU, it can
>> >>>>> start sending in FPDU mode.
>> >>>> If I understand your statements correctly: in MPA v2
>clint-server
>> >>>> mode,
>> >>>> the responder application should have some logic to wait(after
>> >>>> ESTABLISH
>> >>>> event) until the first FPDU message is received from the
>> >> initiator?
>> >>>>
>> >>>> Thanks,
>> >>>> Krishna.
>> >>>
>> >>> The responder may either delay the established event
>> >>> until it sees the first peer FPDU, or it delays sending
>> >>> the first (now already posted) FPDU, until it sees the
>> >>> first initiator FPDU. This, since (theoretically), the
>> >>> responder does not know yet the result of CRC and
>> >>> Marker negotiation. siw delays the established event,
>> >>> which seems the more clear path to me.
>> >>>
>> >>> This MPA handshake is cumbersome. siw is permissive
>> >>> for violations of these rules to the extend, that the
>> >>> responder shall not send back to back the first FPDU
>> >>> with the MPA reply. If a (Chelsio ?) iWarp adapter
>> >>> would send the first responder FPDU only after it
>> >>> got TCP acked its MPA reply, the chances are high the
>> >>> (siw) iWarp initiator has already transitioned to RTS
>> >>> and it would accept that FPU, even if not having sent
>> >>> it's first FPDU.
>> >>>
>> >>> siw sticks to this rule to that extend, since all receive
>> >>> processing is triggered by socket callbacks (from
>> >>> sk->sk_data_ready()). As long as the QP is not
>> >>> in RTS, all TCP bytestream processing is done by the
>> >>> MPA protocol (code in siw_cm.c). If the QP reaches
>> >>> RTS, RX processing is done bt the full iWarp
>> >>> protocol (code in siw_qp_rx.c for RX).
>> >>> Now, if the higher layer (application) protocol has
>> >>> a semantic where the responder sends the first message,
>> >>> we could end up in an infinite wait for that packet
>> >>> at initiator application side.
>> >>> This, since the complete first FPDU was already
>> >>> received at the TCP socket, while the QP was not in
>> >>> RTS. It will not trigger any additional sk->sk_data_ready()
>> >>> and we are stuck with a FPDU in the socket rx buffer.
>> >>>
>> >>> I implemented that 4 bytes extra data testing only to
>> >>> keep the siw protocol state machine as simple as
>> >>> possible (it is already unfortunately complex, if
>> >>> you count the lines in siw_cm.c), while following
>> >>> the protocol rules.
>> >>>
>> >>> I suggest to correctly implement peer2peer mode and
>> >>> delay the established event at the responder side until
>> >>> it got the negotiated first zero length FPDU. Out
>> >>> of the possible options, siw supports both zero length
>> >>> WRITE and READ, but no SEND, since this would consume
>> >>> an extra receive WQE.
>> >>>
>> >>> As a last resort, I might consider extending the
>> >>> siw state machine to handle those - non-complaint -
>> >>> cases gracefully. But, that would result in different
>> >>> code than just avoiding checking for peer protocol
>> >>> violation.
>> >>
>> >> Bernard, everything you describe in siw seems perfectly valid
>> >> to me, and in fact that's why the MPA enhanced connection mode
>> >> was designed the way it is. I disagree that it's "cumbersome",
>> >> but that's a nit.
>> >>
>> >> The issue is that the responder reaches RTS at a different time
>> >> than the initiator reaches RTR. The original iWARP connection
>> >> model did not make any requirement, and races were possible.
>> >> MPAv2 fixes those.
>> >>
>> > Tom, thanks, exactly. MPAv2 fixes it. And an implementation
>
>Thanks Bernard & Tom,
>
>Could you also please consider making MPA ehanced connection
>mode(with RTR handshake) as default for SIW, as MPA V2 peer-
>to-peer mode seems to be more promising that MPA V2
>client-server Mode, wrt race conditions.
>
>Currently SIW has MPA V2 client-server Mode as default.
>
>
>In siw_main.c:
>         const bool peer_to_peer = 1;
>
>
>Between, as per my observations, the chances of hitting this 'connect
>error' issue is higher with:   SIW(initator)<--->(responder)SIW
>than:    SIW(initator) <---> (responder)hard-iwarp

Good to know! Yes, siw is permissive at responder side, it's
applications responsibility to delay the first message, if p2p
mode is not selected.
What application are you using here (which let's
the responder immediately start using the SQ)? Just to let
me re-create the case w/o effort.
I might produce a fix for siw which can handle that
case for the non-p2p-mode case.

Setting p2p mode as default is another option. I am not
immediately happy with that suggestion, since it adds
another wire transfer as default. The future shall see
those parameters settable. These were module parameters,
but we abandoned that. We should probably come up with
an extension to the RDMA netlink interface, which
makes those protocol specific modes and flavors settable
per device...?

Thanks
Bernard.
>
>
>> > of that fix MUST adhere to the defined rules. If one
>> > negotiates an extra handshake to synchronize, it
>> > MUST adhere to that handshake rules. There is no point in
>> > negotiating an extra handshake, and right away ignoring it.
>> > If the responder wants a zero length WRITE, it MUST use
>> > its reception to synchronize its transition to RTS.
>> > 
>> > Shall we extend the siw state machine to support silly
>> > peer behavior? As said, if I read there is no way of
>> 
>> Of course the right answer to this is "no", but I'd reserve
>> drawing that conclusion until I am certain it won't cause
>> trouble. If existing iWARP implementations don't enforce
>> this, and SIW becomes the odd duck failing connections, then
>> I'm afraid I would have to say "yes" instead.
>> 
>> > making the peer implementation RFC compliant (it would
>> > be unexpected), I'll look into the applicability of
>> > Postel's Rule. But let's make those things explicit.
>> 
>> Explicit is best, agreed.
>> 
>> Tom.
>> 
>> > 
>> >> SIW is certainly within its rights to prevent peers from
>> >> sending prior to responder RTR. I'd suggest that if possible,
>> >> you try to detect the deadlock rather than flatly rejecting any
>> >> incoming bytes. The Internet Principle (be liberal in what you
>> >> accept...), after all.
>> >>
>> >> This same dance happens in IB/RoCE, btw. Just via different
>> >> messages.
>> >>
>> > Interesting!
>> > 
>> > Thanks
>> > Bernard.
>> > 
>> >> Tom.
>> >>
>> >>
>> >>>
>> >>> Thanks,
>> >>> Bernard.
>> >>>
>> >>>
>> >>>>>
>> >>>>> Sorry for the confusion. But the current
>> >>>>> siw code appears to be just correct.
>> >>>>>
>> >>>>> Thanks
>> >>>>> Bernard
>> >>>>>
>> >>>>>
>> >>>>>
>> >>>>>> +       if ((__mpa_rr_revision(cep->mpa.hdr.params.bits) ==
>> >>>>>> MPA_REVISION_2) &&
>> >>>>>> +               (cep->state == SIW_EPSTATE_AWAIT_MPAREP)) {
>> >>>>>> +               int mpa_p2p_mode = cep->mpa.v2_ctrl_req.ord
>&
>> >>>>>> +                               (MPA_V2_RDMA_WRITE_RTR |
>> >>>>>> MPA_V2_RDMA_READ_RTR);
>> >>>>>> +               if (!mpa_p2p_mode)
>> >>>>>> +                       extra_data_check = 0;
>> >>>>>> +       }
>> >>>>>> +
>> >>>>>>          /*
>> >>>>>>           * At this point, we must have hdr->params.pd_len
>!= 0.
>> >>>>>>           * A private data buffer gets allocated if
>> >>>> hdr->params.pd_len
>> >>>>>> !=
>> >>>>>>           * 0.
>> >>>>>>           */
>> >>>>>>          if (!cep->mpa.pdata) {
>> >>>>>> -               cep->mpa.pdata = kmalloc(pd_len + 4,
>> >> GFP_KERNEL);
>> >>>>>> +               cep->mpa.pdata = kmalloc(pd_len +
>> >>>> extra_data_check,
>> >>>>>> GFP_KERNEL);
>> >>>>>>                  if (!cep->mpa.pdata)
>> >>>>>>                          return -ENOMEM;
>> >>>>>>          }
>> >>>>>>          rcvd = ksock_recv(
>> >>>>>>                  s, cep->mpa.pdata + cep->mpa.bytes_rcvd -
>> >>>>>> sizeof(struct
>> >>>>>> mpa_rr),
>> >>>>>> -               to_rcv + 4, MSG_DONTWAIT);
>> >>>>>> +               to_rcv + extra_data_check, MSG_DONTWAIT);
>> >>>>>>
>> >>>>>>          if (rcvd < 0)
>> >>>>>>                  return rcvd;
>> >>>>>>
>> >>>>>> -       if (rcvd > to_rcv)
>> >>>>>> +       if (extra_data_check && (rcvd > to_rcv))
>> >>>>>>                  return -EPROTO;
>> >>>>>>
>> >>>>>>          cep->mpa.bytes_rcvd += rcvd;
>> >>>>>>
>> >>>>>> -Krishna.
>> >>>>>>>
>> >>>>>>> Tom.
>> >>>>>>>
>> >>>>>>>
>> >>>>>>>
>> >>>>>>>>
>> >>>>>>>> Bernard.
>> >>>>>>>>
>> >>>>>>>>>
>> >>>>>>>>>> So, for the MPA request case, this code is needed
>> >>>>>>>>>> to check for protocol correctness.
>> >>>>>>>>>> You are right for the MPA reply case - if we are
>> >>>>>>>>>> _not_ in peer2peer mode, the peer can immediately
>> >>>>>>>>>> start sending data in RDMA mode after its MPA Reply.
>> >>>>>>>>>> So we shall add appropriate code to be more specific
>> >>>>>>>>>> For an error, we are (1) processing an MPA Request,
>> >>>>>>>>>> OR (2) processing an MPA Reply AND we are not expected
>> >>>>>>>>>> to send an initial READ/WRITE/Send as negotiated with
>> >>>>>>>>>> the peer (peer2peer mode MPA handshake).
>> >>>>>>>>>>
>> >>>>>>>>>> Just removing this check would make siw more permissive,
>> >>>>>>>>>> but to a point where peer MPA protocol errors are
>> >>>>>>>>>> tolerated. I am not in favor of that level of
>> >>>>>>>>>> forgiveness.
>> >>>>>>>>>>
>> >>>>>>>>>> If possible, please provide an appropriate patch
>> >>>>>>>>>> or (if it causes current issues with another peer
>> >>>>>>>>>> iWarp implementation) just run in MPA peer2peer mode,
>> >>>>>>>>>> where the current check is appropriate.
>> >>>>>>>>>> Otherwise, I would provide an appropriate fix by Monday
>> >>>>>>>>>> (I am still out of office this week).
>> >>>>>>>>>>
>> >>>>>>>>>>
>> >>>>>>>>>> Many thanks and best regards,
>> >>>>>>>>>> Bernard.
>> >>>>>>>>>>
>> >>
>> >>
>> > 
>> > 
>> > 
>
>

